enum SignupServerError: Error {
    case tokenExpired
    case conflict
    case validation(validationResponceDTO: SignupValidationError)
    case unknown
}
