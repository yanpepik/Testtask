struct UserDTO: Decodable {
    let id: Int
    let name: String
    let email: String
    let phone: String
    let position: String
    let position_id: Int
    let photo: String

    func toDomain() -> UsersModel {
        UsersModel(
            id: id,
            name: name,
            position: position,
            position_id: position_id,
            email: email,
            phone: phone,
            avatarURL: photo
        )
    }
}
