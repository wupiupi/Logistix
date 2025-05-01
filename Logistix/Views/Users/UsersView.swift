import SwiftUI

struct UsersView: View {
    @EnvironmentObject private var usersVM: UsersViewModel
    @EnvironmentObject private var mainVM: MainViewModel
    
    @FocusState private var isSearchFocused: Bool
    
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
                .navigationTitle("Logistix")
            }
        }
        .navigationBarBackButtonHidden(true)
        .searchable(
            text: $usersVM.searchTerm,
            prompt: "Поиск пользователей по эл. почте"
        )
        .focused($isSearchFocused)
        .onChange(of: isSearchFocused) { _, focused in
            mainVM.shouldBeHidden = focused
        }
    }
}
