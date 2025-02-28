import SwiftUI

struct OrdersView: View {
    @EnvironmentObject private var authVM: AuthViewModel
    @EnvironmentObject private var ordersVM: OrdersViewModel
    
    private var filteredOrders: [Order] {
        if authVM.currentUser?.role == Role.admin.rawValue {
            guard !ordersVM.searchTerm.isEmpty else {
                return ordersVM.orders
            }
            return ordersVM.orders.filter { $0.id.localizedStandardContains(ordersVM.searchTerm) }
        } else {
            guard !ordersVM.searchTerm.isEmpty else {
                return authVM.currentUser?.orders ?? []
            }
            return authVM.currentUser?.orders.filter {
                $0.id.localizedCaseInsensitiveContains(ordersVM.searchTerm)
            } ?? []
        }
    }
    
    private var userOrders: [Order] {
        filteredOrders.filter { $0.userID == authVM.currentUser?.id ?? ""}
    }
    
    private var driverOrders: [Order] {
        ordersVM.orders.filter {
            ($0.status == OrderStatus.searchingForDriver.rawValue || $0.status == OrderStatus.inProcess.rawValue)
            && ($0.assignedDriverID == "" || $0.assignedDriverID == authVM.currentUser?.id)
        }
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    OrdersTitle(isEmpty: getCorrectOrders().count == 0)
                    
                    ForEach(
                        getCorrectOrders(),
                        id: \.self
                    ) { order in
                        
                        Divider()
                        
                        // Order ID & Date of Loading
                        OrderIdView(order: order)
                        
                        // Expands the details of the order
                        ExpandableOrderView(order: order)
                    }
                }
                .padding()
            }
            .navigationTitle("Logistix")
        }
        .searchable(
            text: $ordersVM.searchTerm,
            prompt: "Поиск по документам или заказам"
        )
        .onAppear {
            ordersVM.updateOrders()
        }
    }
    
    private func getCorrectOrders() -> [Order] {
        switch authVM.currentUser?.role {
            case Role.user.rawValue:
                return userOrders
            case Role.driver.rawValue:
                return driverOrders
            default:
                return filteredOrders
        }
    }
}
