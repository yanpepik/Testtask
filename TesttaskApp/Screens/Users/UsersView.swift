import SwiftUI

struct UsersView<ViewModel: UsersViewModelProtocol & ObservableObject>: View {
    //MARK: - Properties
    @StateObject private var viewModel: ViewModel

    //MARK: - Initialization
    init(viewModel: ViewModel = UsersViewModel()) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    //MARK: - Body
    var body: some View {
        VStack(spacing: 0) {
            TopBar(title: viewModel.headerTitle)

            ScrollView {
                LazyVStack(spacing: 0) {
                    if viewModel.isInitialLoading {

                    } else if viewModel.users.isEmpty {
                        UsersEmpty()
                            .padding(.top, 64)
                    } else {
                        ForEach(Array(viewModel.users.enumerated()), id: \.offset) { index, user in
                            VStack(spacing: 0) {
                                UserCardView(model: userCardModel(for: user))
                                    .onAppear {
                                        viewModel.loadMoreIfNeeded(currentIndex: index)
                                    }
                                if index != viewModel.users.count - 1 {
                                    Divider()
                                        .padding(.leading, 76)
                                        .padding(.trailing, 16)
                                }
                            }
                        }
                    }
                }
                .padding(.top, 8)
                .padding(.bottom, 32)
            }
            .refreshable {
                viewModel.refresh()
            }
        }
        .background(Color.white)
        .onAppear {
            viewModel.fetchUsers(reset: false)
        }
    }

    //MARK: - private Methods
    private func userCardModel(for user: UsersModel) -> UserCardView.Model {
        UserCardView.Model(
            avatarURL: user.avatarURL,
            name: user.name,
            position: Position.from(
                id: user.position_id
            )?.localized ?? LocalizedStringResource(stringLiteral: user.position),
            email: user.email,
            phone: user.phone
        )
    }
}
