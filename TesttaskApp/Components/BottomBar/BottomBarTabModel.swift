import SwiftUI

enum BottomBarModel: Int, CaseIterable {
    case users = 0
    case signup = 1
    
    var label: String {
        switch self {
        case .users: .localization.common.buttonUsers
        case .signup: .localization.common.buttonSignup
        }
    }
    
    var icon: ImageResource {
        switch self {
        case .users: .people
        case .signup: .addUser
        }
    }
    
    var iconSize: CGSize {
        switch self {
        case .users: CGSize(width: 40, height: 17)
        case .signup: CGSize(width: 22, height: 17)
        }
    }
}
