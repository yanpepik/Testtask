import SwiftUI

extension PrimaryFilledButton {
    struct Model {
        let title: String
        let action: () -> Void
        var isEnabled: Binding<Bool>

        init(
            title: String,
            isEnabled: Binding<Bool>,
            action: @escaping () -> Void
        ) {
            self.title = title
            self.isEnabled = isEnabled
            self.action = action
        }
    }
}
