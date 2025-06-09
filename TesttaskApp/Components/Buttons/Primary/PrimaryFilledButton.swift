import SwiftUI

struct PrimaryFilledButton: View {
    // MARK: - Properties
    let title: String
    let action: () -> Void

    @Binding var isEnabled: Bool
    @GestureState private var isPressed = false

    // MARK: - Body
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(FontFamily.Nunito.semibold.font(size: 18))
                .foregroundColor(foregroundColor)
                .padding(.vertical, 12)
                .padding(.horizontal, 24)
                .frame(width: 140)
                .background(backgroundColor)
                .cornerRadius(24)
        }
        .buttonStyle(PlainButtonStyle())
        .disabled(!isEnabled)
        .animation(.easeInOut(duration: 0.15), value: isPressed)
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .updating($isPressed) { _, state, _ in
                    state = true
                }
        )
    }

    private var backgroundColor: Color {
        guard isEnabled else { return .neutralDividerGray }
        return isPressed ? .primaryGold : .accentYellow
    }

    private var foregroundColor: Color {
        isEnabled ? .black.opacity(0.87) : .black.opacity(0.48)
    }
}
