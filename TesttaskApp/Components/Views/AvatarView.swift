import SwiftUI

struct AvatarView: View {
    //MARK: - Properties
    let url: String?
    let size: CGFloat
    
    //MARK: - Body
    var body: some View {
        Group {
            if let validURL = url.flatMap(URL.init) {
                AsyncImage(url: validURL, transaction: Transaction(animation: .default)) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                    case .failure:
                        placeholder
                    default:
                        placeholder
                    }
                }
            } else {
                placeholder
            }
        }
        .frame(width: size, height: size)
        .clipShape(Circle())
        .contentShape(Circle())
    }
    
    private var placeholder: some View {
        Image(.userPlaceholder)
            .resizable()
            .scaledToFill()
    }
}
