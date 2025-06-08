import Foundation

protocol EndpointProtocol {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var headers: [String: String]? { get }
    var parameters: [URLQueryItem]? { get }
    func multipartBody() throws -> (body: Data, boundary: String)?
}

extension EndpointProtocol {
    func multipartBody() throws -> (body: Data, boundary: String)? { nil }
}
