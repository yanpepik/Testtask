import SwiftUI

extension PrimaryTextField {
    struct Model {
        var placeholderText: String
        var characterLimit: Int?
        var errorText: String?
        var fieldType: FieldType
        
        init(
            placeholderText: String,
            characterLimit: Int? = nil,
            errorText: String? = nil,
            fieldType: FieldType
        ) {
            self.placeholderText = placeholderText
            self.characterLimit = characterLimit
            self.errorText = errorText
            self.fieldType = fieldType
        }
    }
    
    enum FieldType {
        case name
        case email
        case phone
        
        var keyboardType: UIKeyboardType {
            switch self {
            case .phone: return .numberPad
            case .email: return .emailAddress
            case .name: return .default
            }
        }
        
        var placeholder: String {
            switch self {
            case .name:
                    .localization.signup.namePlaceholder
            case .email:
                    .localization.signup.emailPlaceholder
            case .phone:
                    .localization.signup.phonePlaceholder
            }
        }
    }
}
