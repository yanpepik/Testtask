import SwiftUI
import Combine

final class UsersViewModel: UsersViewModelProtocol {
    //MARK: - Properties
    private let networkService: NetworkServiceProtocol

    private var currentPage = 1
    private var totalPages = 1
    private var usersPerPage = 4

    @Published private(set) var users: [UsersModel] = []
    @Published private(set) var isInitialLoading = false
    @Published private(set) var isPaginating = false

    var headerTitle: String { .localization.common.headerGET }

    //MARK: - Initialization
    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }

    //MARK: - Methods
    func fetchUsers(reset: Bool) {
        if reset {
            currentPage = 1
            totalPages = 1
            users = []
        }

        guard currentPage <= totalPages else { return }

        if reset {
            isInitialLoading = true
        } else {
            isPaginating = true
        }

        Task {
            do {
                let request = Request<Empty>(
                    endpoint: UsersEndpoint.getUsers(page: currentPage, count: usersPerPage),
                    method: .GET
                )
                let response: Response<UsersResponse> = try await networkService.performRequest(request: request)
                let newUsers = response.body.users.map { $0.toDomain() }

                await MainActor.run {
                    users.append(contentsOf: newUsers)
                    totalPages = response.body.totalPages
                    usersPerPage = response.body.count
                    currentPage += 1
                    isInitialLoading = false
                    isPaginating = false
                }
            } catch {
                await MainActor.run {
                    isInitialLoading = false
                    isPaginating = false
                }
            }
        }
    }

    func loadMoreIfNeeded(currentIndex index: Int) {
        let thresholdIndex = users.count - 3
        guard index >= thresholdIndex else { return }
        guard !isPaginating, currentPage <= totalPages else { return }

        fetchUsers(reset: false)
    }

    func refresh() {
        fetchUsers(reset: true)
    }
}
