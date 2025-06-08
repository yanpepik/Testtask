import SwiftUI

struct SecondaryTextButton: View {
    // MARK: - Properties
    let title: String
    let action: () -> Void

    @Binding var isEnabled: Bool
    @GestureState private var isPressed = false

    // MARK: - Body
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(FontFamily.Nunito.semibold.font(size: 16))
                .foregroundColor(foregroundColor)
                .padding(.vertical, 8)
                .padding(.horizontal, 16)
                .background(backgroundColor)
                .cornerRadius(24)
        }
        .disabled(!isEnabled)
        .animation(.easeInOut(duration: 0.15), value: isPressed)
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .updating($isPressed) { _, state, _ in
                    state = true
                }
        )
        .buttonStyle(PlainButtonStyle())
    }

    private var foregroundColor: Color {
        isEnabled ? .actionCyan : .black.opacity(0.48)
    }

    private var backgroundColor: Color {
        guard isEnabled else { return .clear }
        return isPressed ? .functionalCyan.opacity(0.1) : .clear
    }
}
