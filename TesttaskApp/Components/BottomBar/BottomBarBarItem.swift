import SwiftUI

struct BottomBarBarItem: View {
    let tab: BottomBarModel
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                Image(tab.icon)
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .frame(width: tab.iconSize.width, height: tab.iconSize.height)
                
                Text(tab.label)
                    .font(FontFamily.Nunito.regular.font(size: 14))
            }
            .foregroundColor(isSelected ? .functionalCyan : .black.opacity(0.6))
        }
    }
}
