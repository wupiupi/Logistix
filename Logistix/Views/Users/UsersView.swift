import SwiftUI

struct UsersView: View {
    @EnvironmentObject private var usersVM: UsersViewModel

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    ForEach(usersVM.filteredUsers) { user in
                        Divider()
                        UserIdView(user: user)
                        ExpandableUserView(user: user)
                    }
                }
                .padding()
            }
            .searchable(
                text: $usersVM.searchTerm,
                prompt: "Поиск пользователей по UID"
            )
            .navigationTitle("Logistix")
        }
    }
}
