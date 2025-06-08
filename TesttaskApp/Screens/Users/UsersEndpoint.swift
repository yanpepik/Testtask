import Foundation

enum UsersEndpoint: EndpointProtocol {
    case getUsers(page: Int, count: Int)

    var scheme: String { "https" }
    var host: String { "frontend-test-assignment-api.abz.agency" }
    var path: String { "/api/v1/users" }

    var parameters: [URLQueryItem]? {
        switch self {
        case .getUsers(let page, let count):
            return [
                URLQueryItem(name: "page", value: "\(page)"),
                URLQueryItem(name: "count", value: "\(count)")
            ]
        }
    }

    var headers: [String: String]? {
        ["Accept": "application/json"]
    }
}
