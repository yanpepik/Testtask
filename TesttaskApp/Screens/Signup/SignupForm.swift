import Foundation

struct SignupForm {
    var name: String = ""
    var email: String = ""
    var phone: String = ""
    var selectedPosition: Position = .frontend
    var isPhotoSelected: Bool = false
    var photoData: Data = .userPlaceholder

    var nameError: String? = nil
    var emailError: String? = nil
    var phoneError: String? = nil
    var photoError: String? = nil
}

private extension Data {
    static var userPlaceholder: Data {
        guard
            let url = Bundle.main.url(forResource: "userPlaceholder", withExtension: "jpg"),
            let data = try? Data(contentsOf: url)
        else {
            return Data()
        }
        return data
    }
}
