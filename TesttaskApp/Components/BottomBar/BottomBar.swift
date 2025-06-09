import SwiftUI

struct BottomBar: View {
    // MARK: - Properties
    @Binding var selectedTab: BottomBarModel

    // MARK: - Body
    var body: some View {
        HStack {
            ForEach(BottomBarModel.allCases, id: \.self) { tab in
                Spacer()
                BottomBarBarItem(tab: tab, isSelected: selectedTab == tab) {
                    selectedTab = tab
                }
                Spacer()
            }
        }
        .padding(.vertical, 16)
        .background(Color.backgroundGray)
    }
}
