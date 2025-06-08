import Foundation

final class MultipartFormDataBuilder {
    //MARK: - Properties
    private var bodyParts: [Data] = []
    
    let boundary: String
    
    //MARK: - Initialization
    init(boundary: String = UUID().uuidString) {
        self.boundary = boundary
    }
    
    //MARK: - Methods
    @discardableResult
    func addField(name: String, value: String) -> Self {
        var field = ""
        field += "--\(boundary)\r\n"
        field += "Content-Disposition: form-data; name=\"\(name)\"\r\n\r\n"
        field += "\(value)\r\n"
        if let data = field.data(using: .utf8) {
            bodyParts.append(data)
        }
        return self
    }
    
    @discardableResult
    func addFile(fieldName: String, fileName: String, mimeType: String, fileData: Data) -> Self {
        var field = ""
        field += "--\(boundary)\r\n"
        field += "Content-Disposition: form-data; name=\"\(fieldName)\"; filename=\"\(fileName)\"\r\n"
        field += "Content-Type: \(mimeType)\r\n\r\n"
        var data = Data()
        data.append(field.data(using: .utf8)!)
        data.append(fileData)
        data.append("\r\n".data(using: .utf8)!)
        bodyParts.append(data)
        return self
    }
    
    func build() throws -> (body: Data, headers: [String: String], boundary: String) {
        guard !bodyParts.isEmpty else {
            throw NSError(
                domain: "MultipartFormDataBuilder",
                code: -1,
                userInfo: [NSLocalizedDescriptionKey: "No fields added"]
            )
        }
        
        var finalData = Data()
        for part in bodyParts {
            finalData.append(part)
        }
        finalData.append("--\(boundary)--\r\n".data(using: .utf8)!)
        
        let headers = [
            "Accept": "application/json"
        ]
        
        return (finalData, headers, boundary)
    }
}
