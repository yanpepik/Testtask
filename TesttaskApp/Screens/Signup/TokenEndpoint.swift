import Foundation

enum SignupEndpoint: EndpointProtocol {
    case getToken
    case registerUser(dto: SignupUserDto)

    var scheme: String { "https" }

    var host: String { "frontend-test-assignment-api.abz.agency" }

    var path: String {
        switch self {
        case .registerUser:
            return "/api/v1/users"
        case .getToken:
            return "/api/v1/token"
        }
    }

    var headers: [String: String]? {
        switch self {
        case .registerUser(let dto):
            return [
                "Token": dto.token,
                "Accept": "application/json"
            ]
        case .getToken:
            return [
                "Accept": "application/json"
            ]
        }
    }

    var parameters: [URLQueryItem]? { nil }

    func multipartBody() throws -> (body: Data, boundary: String)? {
        switch self {
        case .registerUser(let dto):
            let builder = MultipartFormDataBuilder()
                .addField(name: "name", value: dto.name)
                .addField(name: "email", value: dto.email)
                .addField(name: "phone", value: dto.phone)
                .addField(name: "position_id", value: "\(dto.positionId)")
                .addFile(fieldName: "photo", fileName: "user.jpg", mimeType: "image/jpeg", fileData: dto.photo)

            let (body, _, boundary) = try builder.build()
            return (body, boundary)

        default:
            return nil
        }
    }
}

struct TokenResponse: Decodable {
    let success: Bool
    let token: String
}
