import Foundation

extension String {
    enum localization {
        enum common {
            static let textfieldIsEmpty = "common.textfield.isempty".localized
            static let headerGET = "common.header.get".localized
            static let headerPOST = "common.header.post".localized
            static let buttonTryAgain = "common.button.tryagain".localized
            static let buttonGotIt = "common.button.gotit".localized
            static let buttonSignup = "common.button.signup".localized
            static let buttonCancel = "common.button.cancel".localized
            static let buttonUpload = "common.button.upload".localized
            static let buttonUsers = "topbar.button.users".localized
            static let usersEmptyTitle = "usersempty.message".localized
        }

        enum network {
            static let successTitle = "signup.success.title".localized
            static let failureTitle = "signup.failure.title".localized
            static let noConnectionTitle = "signup.noconnection.title".localized
            static let usersEmptyTitle = "signup.usersempty.title".localized
        }

        enum signup {
            static let namePlaceholder = "signup.name.placeholder".localized
            static let nameValidationError = "signup.name.error.validation".localized

            static let emailPlaceholder = "signup.email.placeholder".localized
            static let emailValidationError = "signup.email.error.validation".localized

            static let phonePlaceholder = "signup.phone.placeholder".localized
            static let phoneValidationError = "signup.phone.error.validation".localized
            static let phoneHint = "signup.phone.hint.country.code".localized

            static let photoTitle = "signup.photo.title".localized
            static let photoValidationError = "signup.photo.error.validation".localized

            static let positionTitle = "signup.position.title".localized
            static let positionFrontendDeveloper = "signup.position.frontenddeveloper".localized
            static let positionBackendDeveloper = "signup.position.backenddeveloper".localized
            static let positionDesigner = "signup.position.designer".localized
            static let positionQA = "signup.position.qa".localized

            static let serverErrorTokenExpired = "signup.server.error.tokenExpired".localized
            static let serverErrorUnknown = "signup.server.error.unknown".localized

            static let dialogTitle = "signup.dialog.title".localized
            static let dialogCamera = "signup.dialog.camera".localized
            static let dialogGallery = "signup.dialog.gallery".localized
        }
    }
}

private extension String {
    var localized: String {
        let resourse = LocalizedStringResource(.init(self), table: "Localization")
        return String(localized: resourse)
    }
}
