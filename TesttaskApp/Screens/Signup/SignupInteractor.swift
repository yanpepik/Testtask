import Foundation

protocol SignupInteractorProtocol {
    func fetchToken() async throws -> String
    func submitSignupForm(dto: SignupUserDto) async throws
}

final class SignupInteractor: SignupInteractorProtocol {
    //MARK: - Properties
    private let networkService: NetworkServiceProtocol

    //MARK: - Initialization
    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }

    //MARK: - Methods
    func fetchToken() async throws -> String {
        let request = Request<Empty>(
            endpoint: SignupEndpoint.getToken,
            method: .POST
        )
        let response: Response<TokenResponse> = try await networkService.performRequest(request: request)
        return response.body.token
    }

    func submitSignupForm(dto: SignupUserDto) async throws {
        let request = Request<Empty>(
            endpoint: SignupEndpoint.registerUser(dto: dto),
            method: .POST
        )

        do {
            let _: Response<Empty> = try await networkService.performRequest(request: request)
        } catch let error as NetworkError {
            switch error.statusCode {
            case 401:
                throw SignupServerError.tokenExpired
            case 409:
                throw SignupServerError.conflict
            case 422:
                guard
                    let data = error.rawData,
                    let validation = try? JSONDecoder().decode(SignupValidationError.self, from: data)
                else {
                    fallthrough
                }
                throw SignupServerError.validation(validationResponceDTO: validation)
            default:
                throw error
            }
        }
    }
}
