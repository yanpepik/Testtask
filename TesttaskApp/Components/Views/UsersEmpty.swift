import SwiftUI

struct UsersEmpty: View {
    //MARK: - Body
    var body: some View {
        VStack(spacing: 24) {
            Spacer()
            
            Image(.usersEmpty)
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
            
            Text(LocalizedStringResource(.init( .localization.common.usersEmptyTitle)))
                .font(FontFamily.Nunito.regular.font(size: 20))
                .multilineTextAlignment(.center)
                .foregroundColor(.black)
            
            Spacer()
        }
        .padding()
    }
}
