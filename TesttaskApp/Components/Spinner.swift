import SwiftUI

struct Spinner: View {
    //MARK: - Properties
    @State var isAnimating: Bool
    
    //MARK: - Body
    var body: some View {
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle())
            .onAppear {
                isAnimating = true
            }
    }
}
