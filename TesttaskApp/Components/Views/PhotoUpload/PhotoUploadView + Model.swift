import SwiftUI

extension PhotoUploadView {
    struct Model {
        let title: String
        let errorText: String?
        let isPhotoSelected: Binding<Bool>
        let onUploadTap: () -> Void
        
        init(
            title: String,
            errorText: String? = nil,
            isPhotoSelected: Binding<Bool>,
            onUploadTap: @escaping () -> Void
        ) {
            self.title = title
            self.errorText = errorText
            self.isPhotoSelected = isPhotoSelected
            self.onUploadTap = onUploadTap
        }
    }
}
