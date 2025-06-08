import SwiftUI

struct TopBar: View {
    //MARK: - Properties
    let title: String

    //MARK: - Body
    var body: some View {
        ZStack {
            Color.accentYellow
            Text(title)
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.black)
        }
        .frame(height: 56)
    }
}
