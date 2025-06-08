import Foundation
import SwiftUI

protocol NetworkServiceProtocol {
    func performRequest<BodyType: Encodable, ResponseType: Decodable>(
        request: Request<BodyType>
    ) async throws -> Response<ResponseType>
}

final class NetworkService: NetworkServiceProtocol {
    // MARK: - Methods
    func performRequest<BodyType: Encodable, ResponseType: Decodable>(
        request: Request<BodyType>
    ) async throws -> Response<ResponseType> {
        let urlRequest = try buildURLRequest(for: request)
        do {
            let (data, urlResponse) = try await URLSession.shared.data(for: urlRequest)

            let httpResponse = urlResponse as? HTTPURLResponse
            let headers = httpResponse?.allHeaderFields as? [String: String]

            return try validateStatusCode(httpResponse?.statusCode, data: data, headers: headers)

        } catch let error as NSError {
            if error.code == NSURLErrorTimedOut {
                throw NetworkError(errorType: .timeout, message: error.localizedDescription)
            } else {
                throw NetworkError(
                    errorType: .undefined,
                    message: error.localizedDescription,
                    statusCode: error.code
                )
            }
        }
    }

    // MARK: - Private Methods
    private func buildURLRequest<BodyType: Encodable>(for request: Request<BodyType>) throws -> URLRequest {
        guard let url = buildURL(with: request.endpoint) else { throw NetworkError(errorType: .urlBuilding) }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue

        switch request.method {
        case .PUT, .POST:
            do {
                let encoder = JSONEncoder()
                let encodedBody = try encoder.encode(request.body)
                urlRequest.httpBody = encodedBody
            } catch {
                throw CodingError.encoding
            }
        default:
            break
        }

        if let headers = request.endpoint.headers {
            for (key, value) in headers {
                urlRequest.setValue(value, forHTTPHeaderField: key)
            }
        }

        if let (body, boundary) = try request.endpoint.multipartBody() {
            urlRequest.httpBody = body
            urlRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        }

        return urlRequest
    }

    private func buildURL(with endpoint: EndpointProtocol) -> URL? {
        var components = URLComponents()
        components.scheme = endpoint.scheme
        components.percentEncodedHost = endpoint.host
        components.path = endpoint.path
        components.queryItems = endpoint.parameters

        return components.url
    }

    private func validateStatusCode<ResponseType: Decodable>(
        _ statusCode: Int?,
        data: Data,
        headers: [String: String]?
    ) throws -> Response<ResponseType> {
        guard let statusCode = statusCode else { throw NetworkError(errorType: .undefined, message: "Unknown error") }
        switch statusCode {
        case 200...299:
            let decoder = JSONDecoder()
            do {
                let decodedBody = try decoder.decode(ResponseType.self, from: data)
                let response = Response(statusCode: statusCode, headers: headers, body: decodedBody)
                return response
            } catch {
                throw CodingError.decoding
            }

        case 300...399:
            throw NetworkError(
                errorType: .redirection,
                headers: headers,
                statusCode: statusCode,
                rawData: data
            )

        default:
            throw NetworkError(
                headers: headers,
                statusCode: statusCode,
                rawData: data
            )
        }
    }
}
