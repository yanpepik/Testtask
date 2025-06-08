import SwiftUI

struct RadioCircle: View {
    //MARK: - Properties
    let isSelected: Bool
    let isPressed: Bool

    //MARK: - Body
    var body: some View {
        ZStack {
            Circle()
                .fill(.functionalCyan.opacity(isPressed ? 0.1 : 0))
                .frame(width: 48, height: 48)

            ZStack {
                Circle()
                    .fill(isSelected ? .functionalCyan : .white)
                    .frame(width: 14, height: 14)
                    .overlay(
                        Circle()
                            .stroke(isSelected ? .clear : .neutralGray.opacity(0.4), lineWidth: 1)
                    )
                    .shadow(color: .black.opacity(isSelected ? 0.16 : 0), radius: 2, x: 0, y: 0)

                if isSelected {
                    Circle()
                        .fill(.white)
                        .frame(width: 6, height: 6)
                }
            }
        }
        .animation(.easeInOut(duration: 0.1), value: isSelected)
        .animation(.easeInOut(duration: 0.1), value: isPressed)
    }
}
