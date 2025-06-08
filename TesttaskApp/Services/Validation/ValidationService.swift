import Foundation

protocol ValidationServiceProtocol {
    func validateName(_ name: String) -> String?
    func validateEmail(_ email: String) -> String?
    func validatePhone(_ phone: String) -> String?
    func validatePhoto(_ data: Data) -> String?
}

final class ValidationService {
    //MARK: - Properties
    private let phoneRules: [PhoneRule] = [PhoneRule(prefix: "+380", length: .fixed(13))]
    private let emailRegex = try? Regex(#"^\S+@\S+\.\S+$"#)
}

extension ValidationService: ValidationServiceProtocol {
    func validateName(_ name: String) -> String? {
        let trimmed = name.trimmingCharacters(in: .whitespaces)
        guard !trimmed.isEmpty else {  return .localization.common.textfieldIsEmpty }
        return (2...60).contains(trimmed.count) ? nil : .localization.signup.nameValidationError
    }

    func validateEmail(_ email: String) -> String? {
            let trimmed = email.trimmingCharacters(in: .whitespaces)
        guard !trimmed.isEmpty else { return .localization.common.textfieldIsEmpty }
        guard let regex = emailRegex else { return .localization.signup.emailValidationError }

        return trimmed.firstMatch(of: regex) != nil ? nil : .localization.signup.emailValidationError
        }

    func validatePhone(_ phone: String) -> String? {
        let trimmed = phone.trimmingCharacters(in: .whitespaces)
        guard !trimmed.isEmpty else { return .localization.common.textfieldIsEmpty }
        guard
            let rule = phoneRules.first(where: { trimmed.hasPrefix($0.prefix) })
        else {
            return .localization.signup.phoneValidationError
        }
        return rule.isValid(trimmed) ? nil : .localization.signup.phoneValidationError
    }

    func validatePhoto(_ data: Data) -> String? {
        let maxSizeInBytes = 5 * 1024 * 1024
        guard !data.isEmpty else { return .localization.common.textfieldIsEmpty }
        guard data.count <= maxSizeInBytes else { return .localization.signup.photoValidationError }
        return nil
    }
}
