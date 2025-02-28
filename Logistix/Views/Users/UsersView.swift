import SwiftUI

struct UsersView: View {
    @EnvironmentObject private var usersVM: UsersViewModel
    @EnvironmentObject private var ordersVM: OrdersViewModel
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
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
