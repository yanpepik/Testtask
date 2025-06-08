struct UsersResponse: Decodable {
    let success: Bool
    let page: Int
    let totalPages: Int
    let totalUsers: Int
    let count: Int
    let links: PageLinks
    let users: [UserDTO]

    private enum CodingKeys: String, CodingKey {
        case success, page, count, users, links
        case totalPages = "total_pages"
        case totalUsers = "total_users"
    }
}

struct PageLinks: Decodable {
    let nextURL: String?
    let prevURL: String?

    private enum CodingKeys: String, CodingKey {
        case nextURL = "next_url"
        case prevURL = "prev_url"
    }
}
