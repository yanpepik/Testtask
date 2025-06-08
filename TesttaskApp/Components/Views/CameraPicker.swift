import SwiftUI
import UIKit

struct CameraPicker: UIViewControllerRepresentable {
    //MARK: - Properties
    @Environment(\.presentationMode) var presentationMode
    
    var onImagePicked: (UIImage) -> Void
    
    //MARK: - Methods
    func makeUIViewController(context: Context) -> UIImagePickerController {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else { return UIImagePickerController() }

        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.delegate = context.coordinator
        picker.allowsEditing = false
        picker.modalPresentationStyle = .fullScreen
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}
