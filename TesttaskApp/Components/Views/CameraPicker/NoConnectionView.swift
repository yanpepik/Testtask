import SwiftUI

struct NoConnectionView: View {
    //MARK: - Properties
    let image: ImageResource
    let title: String
    let buttonModel: PrimaryFilledButton.Model

    //MARK: - Initialization
    var body: some View {
        VStack(spacing: 24) {
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
        }
        .padding()
    }
}
