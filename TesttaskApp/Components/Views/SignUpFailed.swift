import SwiftUI

struct SignupFailed: View {
    //MARK: - Properties
    let image: ImageResource
    let title: String
    let buttonModel: PrimaryFilledButton.Model
    let onClose: () -> Void
    
    //MARK: - Body
    var body: some View {
        VStack(spacing: 24) {
            HStack {
                Spacer()
                Button(action: onClose) {
                    Image(systemName: "xmark")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                        .foregroundColor(.black)
                        .padding(12)
                }
            }
            
            Spacer()
            
            Image(image)
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
            
            Text(title)
                .font(FontFamily.Nunito.regular.font(size: 20))
                .multilineTextAlignment(.center)
                .foregroundColor(.black)
            
            PrimaryFilledButton(
                title: buttonModel.title,
                action: buttonModel.action,
                isEnabled: buttonModel.isEnabled
            )
            
            Spacer()
        }
        .padding()
    }
}
