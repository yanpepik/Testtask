import SwiftUI

struct MainView: View {
    //MARK: - Properties
    @StateObject private var networkMonitor: NetworkMonitoringService = NetworkMonitoringService()
    @State private var selectedTab: BottomBarModel = .users

    //MARK: - Body
    var body: some View {
        VStack(spacing: 0) {
            if networkMonitor.isConnected {
                contentView
                bottomBar
            } else {
                noConnectionView
            }
        }
    }

    private var contentView: some View {
        TabView(selection: $selectedTab) {
            UsersView()
                .tag(BottomBarModel.users)

            SignupView()
                .tag(BottomBarModel.signup)
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .ignoresSafeArea(.keyboard)
    }

    private var bottomBar: some View {
        BottomBar(selectedTab: $selectedTab)
            .background(.backgroundGray)
    }

    private var noConnectionView: some View {
        NoConnectionView(
            image: .noConnection,
            title: .localization.network.noConnectionTitle,
            buttonModel: .init(
                title: .localization.common.buttonTryAgain,
                isEnabled: .constant(true),
                action: { networkMonitor.recheck() }
            )
        )
    }
}
