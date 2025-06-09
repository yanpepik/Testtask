import SwiftUI

struct PositionSelectionView: View {
    //MARK: - Properties
    @Binding var selected: Position
    @State private var pressedPosition: Position?
    
    //MARK: - Body
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(LocalizedStringResource(.init(.localization.signup.positionTitle)))
                .font(FontFamily.Nunito.regular.font(size: 18))
                .foregroundColor(.black.opacity(0.87))
            
            ForEach(Position.allCases, id: \.self) { position in
                HStack {
                    RadioCircle(
                        isSelected: selected == position,
                        isPressed: pressedPosition == position
                    )
                    .contentShape(Circle())
                    .gesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged { _ in
                                if pressedPosition != position {
                                    pressedPosition = position
                                }
                            }
                            .onEnded { _ in
                                selected = position
                                pressedPosition = nil
                            }
                    )
                    
                    Text(position.localized)
                        .font(FontFamily.Nunito.regular.font(size: 16))
                        .foregroundColor(.black.opacity(0.87))
                    
                    Spacer()
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    selected = position
                }
            }
        }
        .padding()
    }
}
