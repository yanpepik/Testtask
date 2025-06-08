import SwiftUI

extension SecondaryTextButton {
    public struct Model {
        let title: String
        let action: () -> Void
        var isEnabled: Binding<Bool>

        public init(
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
