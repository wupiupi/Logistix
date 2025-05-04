import SwiftUI

struct OrdersHistoryView: View {
    @EnvironmentObject private var authVM: AuthViewModel
    @EnvironmentObject private var ordersVM: OrdersViewModel
    @EnvironmentObject private var mainVM: MainViewModel
    
    @FocusState private var isSearchFocused: Bool

    private var driverOrders: [Order] {
        ordersVM.orders.filter {
            $0.assignedDriverID == authVM.currentUser?.id
        }
    }
    
    private var filteredOrders: [Order] {
        guard !ordersVM.searchTerm.isEmpty else {
            return driverOrders
        }
        return driverOrders.filter {
            $0.id.localizedCaseInsensitiveContains(ordersVM.searchTerm)
        }
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    OrdersTitle(title: "История Ваших заказов")
                    
                    ForEach(
                        filteredOrders,
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
        .focused($isSearchFocused)
            .onChange(of: isSearchFocused) { _, focused in
                mainVM.shouldBeHidden = focused
            }
        .searchable(
            text: $ordersVM.searchTerm,
            prompt: "Поиск по документам или заказам"
        )
    }
}
