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
                        Spinner(isAnimating: true)
                            .padding(.top, 32)
                    } else if viewModel.users.isEmpty {
                        UsersEmpty()
                            .padding(.top, 64)
                    } else {
                        ForEach(viewModel.users.indices, id: \.self) { index in
                            UserCardView(model: userCardModel(for: viewModel.users[index]))
                                .onAppear {
                                    viewModel.loadMoreIfNeeded(currentIndex: index)
                                }
                        }

                        if viewModel.isPaginating {
                            Spinner(isAnimating: true)
                                .padding(.vertical, 16)
                        }
                    }
                }
                .padding(.bottom, 32)
            }
            .refreshable {
                viewModel.refresh()
            }
        }
        .background(.white)
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
