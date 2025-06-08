import Foundation

struct SignupUserDto {
    let token: String
    let name: String
    let email: String
    let phone: String
    let positionId: Int
    let photo: Data
}
