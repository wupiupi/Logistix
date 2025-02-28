import SwiftUI

struct UsersView: View {
    @EnvironmentObject private var usersVM: UsersViewModel
    @EnvironmentObject private var ordersVM: OrdersViewModel
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    UsersTitle()
                    
                    ForEach(usersVM.users) {
                        
                        Divider()
                        
                        // Order ID & Date of Loading
                        UserIdView(user: $0)
                        
                        // Expands the details of the order
                        ExpandableUserView(user: $0)
                    }
                }
                .padding()
            }
            
            .navigationTitle("Logistix")
        }
    }
}

struct UsersTitle: View {
    var body: some View {
        Text("Пользователи")
            .modifier(
                TitleModifier(
                    font: .largeTitle,
                    fontWeight: .semibold,
                    color: Color(hex: 0x363746, alpha: 1)
                )
            )
    }
}
