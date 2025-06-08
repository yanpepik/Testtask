import Foundation

protocol UsersViewModelProtocol: ObservableObject {
    var users: [UsersModel] { get }
    var isInitialLoading: Bool { get }
    var isPaginating: Bool { get }
    var headerTitle: String { get }

    func fetchUsers(reset: Bool)
    func loadMoreIfNeeded(currentIndex index: Int)
    func refresh()
}
