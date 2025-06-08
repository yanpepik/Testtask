import SwiftUI

struct UserCardView: View {
    // MARK: - Properties
    let model: Model
    
    // MARK: - Body
    var body: some View {
        VStack(spacing: 16) {
            HStack(alignment: .top, spacing: 16) {
                AvatarView(url: model.avatarURL, size: 50)
                    .clipShape(Circle())
                
                VStack(alignment: .leading, spacing: 8) {
                    Text(model.name)
                        .font(FontFamily.Nunito.regular.font(size: 18))
                        .foregroundColor(.black)
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.leading)
                    
                    Text(model.position)
                        .font(FontFamily.Nunito.regular.font(size: 14))
                        .foregroundColor(.black.opacity(0.6))
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.leading)
                    
                    Text(model.email)
                        .font(FontFamily.Nunito.regular.font(size: 14))
                        .foregroundColor(.black.opacity(0.87))
                        .lineLimit(1)
                        .truncationMode(.tail)
                    
                    Text(model.phone)
                        .font(FontFamily.Nunito.regular.font(size: 14))
                        .foregroundColor(.black.opacity(0.87))
                    
                    Divider()
                }
                
                Spacer(minLength: 0)
            }
            .padding(.top, 24)
            .padding(.horizontal, 16)
        }
        .background(.white)
    }
}
