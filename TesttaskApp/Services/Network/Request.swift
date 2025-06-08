import Foundation

struct Request<BodyType: Encodable> {
    // MARK: - Properties
    let endpoint: EndpointProtocol
    let method: RequestMethod
    let body: BodyType?
    
    // MARK: - Initialization
    init(
        endpoint: EndpointProtocol,
        method: RequestMethod,
        body: BodyType? = nil
    ) {
        self.endpoint = endpoint
        self.method = method
        self.body = body
    }
}

extension Request where BodyType == Empty {
    init(
        endpoint: EndpointProtocol,
        method: RequestMethod
    ) {
        self.init(
            endpoint: endpoint,
            method: method,
            body: Empty()
        )
    }
}

struct Empty: Codable {}
