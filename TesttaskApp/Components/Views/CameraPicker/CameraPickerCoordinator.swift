import UIKit

final class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    //MARK: - Properties
    private let parent: CameraPicker
    
    //MARK: - Initialization
    init(_ parent: CameraPicker) {
        self.parent = parent
    }
    
    //MARK: - Methods
    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]
    ) {
        if let image = info[.originalImage] as? UIImage {
            parent.onImagePicked(image)
        }
        parent.presentationMode.wrappedValue.dismiss()
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        parent.presentationMode.wrappedValue.dismiss()
    }
}
