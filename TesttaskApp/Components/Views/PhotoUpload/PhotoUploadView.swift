import SwiftUI

struct PhotoUploadView: View {
    //MARK: - Properties
    let model: Model
    
    //MARK: - Body
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text(model.title)
                    .font(FontFamily.Nunito.regular.font(size: 16))
                    .foregroundColor(mainColor)

                Spacer()
                
                SecondaryTextButton(
                    title: .localization.common.buttonUpload,
                    action: model.onUploadTap,
                    isEnabled: .constant(true)
                )
                .frame(height: 30)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 16)
            .overlay(
                RoundedRectangle(cornerRadius: 4)
                    .stroke(mainColor, lineWidth: 1)
            )
            
            if let errorText = model.errorText, !model.isPhotoSelected.wrappedValue {
                Text(errorText)
                    .font(FontFamily.Nunito.regular.font(size: 12))
                    .foregroundColor(.red)
                    .padding(.horizontal, 16)
            }
        }
    }
    
    private var mainColor: Color {
        !model.isPhotoSelected.wrappedValue && model.errorText != nil ? .red : .black.opacity(0.48)
    }
}
