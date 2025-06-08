import SwiftUI
import _PhotosUI_SwiftUI

final class SignupViewModel: SignupViewModelProtocol {
    //MARK: - Properties
    private let validator: ValidationServiceProtocol
    private let interactor: SignupInteractorProtocol
    
    private var isValidationEnabled = false
    
    @Published var form = SignupForm()
    @Published var status: SignupStatus = .none
    @Published var isCameraPresented = false
    @Published var isPhotoPickerPresented = false
    
    var showSuccessSheet: Bool { status == .success }
    var showFailedSheet: Bool {
        if case .failed = status { return true }
        return false
    }
    
    var failureMessage: String? {
        if case .failed(let message) = status { return message }
        return nil
    }
    
    var successButtonTitle: String { .localization.common.buttonGotIt }
    var successTitle: String { .localization.network.successTitle }
    var failureButtonTitle: String { .localization.common.buttonTryAgain }
    var failureTitle: String { .localization.network.failureTitle }
    var headerTitle: String { .localization.common.headerPOST }
    var signupButtonTitle: String { .localization.common.buttonSignup }
    var namePlaceholder: String { .localization.signup.namePlaceholder }
    var emailPlaceholder: String { .localization.signup.emailPlaceholder }
    var phonePlaceholder: String { .localization.signup.phonePlaceholder }
    var photoTitle: String { .localization.signup.photoTitle }
    var positionTitle: String { .localization.signup.positionTitle }
    var dialogTitle: String { .localization.signup.dialogTitle }
    var dialogGallery: String { .localization.signup.dialogGallery }
    var dialogCamera: String { .localization.signup.dialogCamera }
    var dialogCancel: String { .localization.common.buttonCancel }
    
    var errorName: String? { isValidationEnabled ? validator.validateName(form.name) : form.nameError }
    var errorEmail: String? { isValidationEnabled ? validator.validateEmail(form.email) : form.emailError }
    var errorPhone: String? { isValidationEnabled ? validator.validatePhone(form.phone) : form.phoneError }
    var errorPhoto: String? { isValidationEnabled ? validator.validatePhoto(form.photoData) : form.photoError }
    
    var isFormFilled: Bool {
        !form.name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        !form.email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        !form.phone.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        !form.photoData.isEmpty
    }
    
    //MARK: - Initialization
    init(
        validator: ValidationServiceProtocol = ValidationService(),
        interactor: SignupInteractorProtocol = SignupInteractor()
    ) {
        self.validator = validator
        self.interactor = interactor
    }
    
    //MARK: - Methods
    func startPhotoPicker() {
        isPhotoPickerPresented = true
    }
    
    func handlePhotoPickerItem(_ item: PhotosPickerItem) {
        Task {
            guard let type = item.supportedContentTypes.first,
                  type.conforms(to: .jpeg),
                  let data = try? await item.loadTransferable(type: Data.self) else {
                status = .failed(message: .localization.signup.photoValidationError)
                return
            }
            setPhotoData(data)
        }
    }
    
    func setPhotoData(_ data: Data) {
        Task { @MainActor in
            form.photoData = data
            form.isPhotoSelected = true
        }
    }
    
    func startCamera() {
        isCameraPresented = true
    }
    
    func handleCameraImage(_ image: UIImage) {
        guard let data = image.jpegData(compressionQuality: 0.9),
              image.size.width >= 70, image.size.height >= 70,
              data.count <= 5 * 1024 * 1024 else {
            status = .failed(message: .localization.signup.photoValidationError)
            return
        }
        setPhotoData(data)
    }
    
    func signup() {
        isValidationEnabled = true
        updateFieldErrors()
        
        guard validateAllFields() else { return }
        Task {
            do {
                let token = try await interactor.fetchToken()
                let dto = SignupUserDto(
                    token: token,
                    name: form.name,
                    email: form.email,
                    phone: form.phone,
                    positionId: form.selectedPosition.id,
                    photo: form.photoData
                )
                try await interactor.submitSignupForm(dto: dto)
                await MainActor.run { status = .success }
            } catch let error as SignupServerError {
                await MainActor.run {
                    switch error {
                    case .tokenExpired:
                        status = .failed(message: .localization.signup.serverErrorTokenExpired)
                    case .validation(let validation):
                        form.nameError = validation.fails.name?.first
                        form.emailError = validation.fails.email?.first
                        form.phoneError = validation.fails.phone?.first
                        form.photoError = validation.fails.phone?.first
                    case .conflict:
                        status = .failed(message: .localization.network.failureTitle)
                    case .unknown:
                        status = .failed(message: .localization.signup.serverErrorUnknown)
                    }
                }
            } catch {
                await MainActor.run {
                    status = .failed(message: error.localizedDescription)
                }
            }
        }
    }
    
    func dismissStatus() {
        status = .none
    }
    
    //MARK: - Private Methods
    private func validateAllFields() -> Bool {
        return form.nameError == nil &&
        form.emailError == nil &&
        form.phoneError == nil &&
        form.photoError == nil
    }
    
    private func updateFieldErrors() {
        form.nameError = validator.validateName(form.name)
        form.emailError = validator.validateEmail(form.email)
        form.phoneError = validator.validatePhone(form.phone)
        form.photoError = validator.validatePhoto(form.photoData)
    }
}
