struct SignupValidationError: Codable {
    let fails: Fails
}

extension SignupValidationError {
    struct Fails: Codable {
        let name: [String]?
        let email: [String]?
        let phone: [String]?
        let photo: [String]?
    }
}
