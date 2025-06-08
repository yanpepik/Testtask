import SwiftUI
import PhotosUI

struct SignupView<ViewModel: SignupViewModelProtocol & ObservableObject>: View {
    // MARK: - Properties
    @StateObject private var viewModel: ViewModel

    @State private var showPhotoSourceDialog = false
    @State private var selectedPhotoItem: PhotosPickerItem?

    // MARK: - Initialization
    init(viewModel: ViewModel = SignupViewModel()) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    // MARK: - Body
    var body: some View {
        ZStack {
            VStack(spacing: 12) {
                TopBar(title: viewModel.headerTitle)

                ScrollView {
                    VStack(spacing: 24) {
                        nameField
                        emailField
                        phoneField
                        positionPicker
                        photoUploader
                        submitButton
                    }
                    .padding()
                    .background(Color(uiColor: .systemBackground))
                }
            }
            .confirmationDialog(viewModel.dialogTitle, isPresented: $showPhotoSourceDialog) {
                Button(viewModel.dialogCamera) {
                    viewModel.startCamera()
                }
                Button(viewModel.dialogGallery) {
                    viewModel.startPhotoPicker()
                }
                Button(viewModel.dialogCancel, role: .cancel) { }
            }
            .photosPicker(
                isPresented: $viewModel.isPhotoPickerPresented,
                selection: $selectedPhotoItem,
                matching: .images
            )
            .onChange(of: selectedPhotoItem) { _, item in
                if let item {
                    viewModel.handlePhotoPickerItem(item)
                }
            }
        }
        .hideKeyboardOnTap()
        .fullScreenCover(isPresented: $viewModel.isCameraPresented) {
            ZStack {
                Color.black.ignoresSafeArea()
                CameraPicker { image in
                    viewModel.handleCameraImage(image)
                }
            }
        }
        .sheet(isPresented: isSuccessBinding) {
            SignupSuccess(
                image: .signupSuccess,
                title: viewModel.successTitle,
                buttonModel: successButtonModel,
                onClose: viewModel.dismissStatus
            )
        }
        .sheet(isPresented: isFailedBinding) {
            SignupFailed(
                image: .signupFailed,
                title: viewModel.failureMessage ?? "",
                buttonModel: failedButtonModel,
                onClose: viewModel.dismissStatus
            )
        }
    }

    private var isSuccessBinding: Binding<Bool> {
        Binding(
            get: { viewModel.status == .success },
            set: { if !$0 { viewModel.dismissStatus() } }
        )
    }

    private var isFailedBinding: Binding<Bool> {
        Binding(
            get: { viewModel.showFailedSheet },
            set: { if !$0 { viewModel.dismissStatus() } }
        )
    }

    private var submitButtonEnabled: Binding<Bool> {
        Binding(
            get: { viewModel.isFormFilled },
            set: { _ in }
        )
    }

    private var successButtonModel: PrimaryFilledButton.Model {
        .init(
            title: viewModel.successButtonTitle,
            isEnabled: .constant(true),
            action: viewModel.dismissStatus
        )
    }

    private var failedButtonModel: PrimaryFilledButton.Model {
        .init(
            title: viewModel.signupButtonTitle,
            isEnabled: .constant(true),
            action: viewModel.dismissStatus
        )
    }

    private var photoUploadModel: PhotoUploadView.Model {
        .init(
            title: viewModel.photoTitle,
            errorText: viewModel.errorPhoto,
            isPhotoSelected: .constant(!viewModel.form.photoData.isEmpty),
            onUploadTap: { showPhotoSourceDialog = true }
        )
    }

    private var nameField: some View {
        PrimaryTextField(
            model: .init(
                placeholderText: viewModel.namePlaceholder,
                characterLimit: 60,
                errorText: viewModel.errorName,
                fieldType: .name
            ),
            text: $viewModel.form.name
        )
    }

    private var emailField: some View {
        PrimaryTextField(
            model: .init(
                placeholderText: viewModel.emailPlaceholder,
                errorText: viewModel.errorEmail,
                fieldType: .email
            ),
            text: $viewModel.form.email
        )
    }

    private var phoneField: some View {
        PrimaryTextField(
            model: .init(
                placeholderText: viewModel.phonePlaceholder,
                characterLimit: 13,
                errorText: viewModel.errorPhone,
                fieldType: .phone
            ),
            text: $viewModel.form.phone
        )
    }

    private var positionPicker: some View {
        PositionSelectionView(selected: $viewModel.form.selectedPosition)
    }

    private var photoUploader: some View {
        PhotoUploadView(model: photoUploadModel)
    }

    private var submitButton: some View {
        PrimaryFilledButton(
            title: viewModel.signupButtonTitle,
            action: viewModel.signup,
            isEnabled: submitButtonEnabled
        )
        .padding(.top, 8)
    }
}
