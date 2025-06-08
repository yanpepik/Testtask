import Foundation

struct UsersModel: Identifiable {
    let id: Int
    let name: String
    let position: String
    let position_id: Int
    let email: String
    let phone: String
    let avatarURL: String?
}
