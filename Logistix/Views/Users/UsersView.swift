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
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            usersVM.isSortSheetPresented = true
                        } label: {
                            Image(systemName: "arrow.up.arrow.down")
                        }
                    }
                }
            }
        }
        .sheet(isPresented: $usersVM.isSortSheetPresented) {
            VStack(alignment: .leading, spacing: 14) {
                HStack {
                    Image(systemName: "arrow.up.arrow.down")
                    Text("Сортировка")
                        .font(.title3.bold())
                    Spacer()
                }
                .padding(.top, 24)
                .padding(.bottom, 12)

                ForEach(UsersViewModel.UsersSortOption.allCases, id: \.self) { option in
                    Button {
                        usersVM.selectedSortOption = option
                        usersVM.isSortSheetPresented = false
                    } label: {
                        HStack {
                            Text(option.rawValue)
                                .foregroundColor(.blue)
                            Spacer()
                            if usersVM.selectedSortOption == option {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.accentColor)
                            }
                        }
                        .padding([.vertical, .horizontal], 12)
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                    }
                }

                Spacer()
            }
            .padding()
            .presentationDetents([.fraction(0.45)])
        }
        .navigationBarBackButtonHidden(true)
        .searchable(
            text: $usersVM.searchTerm,
            prompt: "Поиск пользователей по эл.почте"
        )
        .focused($isSearchFocused)
        .onChange(of: isSearchFocused) { _, focused in
            mainVM.shouldBeHidden = focused
        }
    }
}
