import Foundation

enum ErrorType: String, Decodable {
    case urlBuilding
    case redirection
    case undefined
    case timeout
}

enum CodingError: Error, Decodable {
    case decoding
    case encoding
}

struct NetworkError: Error, Decodable {
    // MARK: - Properties
    let statusCode: Int
    let errorType: ErrorType
    let message: String?
    let headers: [String: String]?
    let rawData: Data?
    
    // MARK: - Initialization
    init(
        errorType: ErrorType = .undefined,
        message: String? = nil,
        headers: [String: String]? = nil,
        statusCode: Int = 0,
        rawData: Data? = nil
    ) {
        self.statusCode = statusCode
        self.errorType = errorType
        self.message = message
        self.headers = headers
        self.rawData = rawData
    }
}
