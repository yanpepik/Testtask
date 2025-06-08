enum SignupStatus: Equatable {
    case none
    case success
    case failed(message: String)
}
