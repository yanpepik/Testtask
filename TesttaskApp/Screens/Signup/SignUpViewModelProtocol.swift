import SwiftUI
import _PhotosUI_SwiftUI

import SwiftUI
import PhotosUI

protocol SignupViewModelProtocol: ObservableObject {
    var form: SignupForm { get set }
    var isFormFilled: Bool { get }

    var errorName: String? { get }
    var errorEmail: String? { get }
    var errorPhone: String? { get }
    var errorPhoto: String? { get }

    var isCameraPresented: Bool { get set }
    var isPhotoPickerPresented: Bool { get set }

    var headerTitle: String { get }
    var signupButtonTitle: String { get }
    var namePlaceholder: String { get }
    var emailPlaceholder: String { get }
    var phonePlaceholder: String { get }
    var photoTitle: String { get }
    var positionTitle: String { get }
    var dialogTitle: String { get }
    var dialogCamera: String { get }
    var successTitle: String { get }
    var failureButtonTitle: String { get }
    var failureTitle: String { get }
    var dialogGallery: String { get }
    var dialogCancel: String { get }

    var successButtonTitle: String { get }
    var showSuccessSheet: Bool { get }
    var showFailedSheet: Bool { get }
    var failureMessage: String? { get }
    var status: SignupStatus { get set }

    func signup()
    func setPhotoData(_ data: Data)
    func startPhotoPicker()
    func handlePhotoPickerItem(_ item: PhotosPickerItem)
    func dismissStatus()
    func startCamera()
    func handleCameraImage(_ image: UIImage)
}
