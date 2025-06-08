import SwiftUI

extension UserCardView {
    struct Model {
        let avatarURL: String?
        let name: String
        let position: LocalizedStringResource
        let email: String
        let phone: String
        
        init(
            avatarURL: String? = nil,
            name: String,
            position: LocalizedStringResource,
            email: String,
            phone: String
        ) {
            self.avatarURL = avatarURL
            self.name = name
            self.position = position
            self.email = email
            self.phone = phone
        }
    }
}
