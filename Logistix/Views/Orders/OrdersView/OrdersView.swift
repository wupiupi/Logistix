import SwiftUI

struct OrdersView: View {
    @EnvironmentObject private var authVM: AuthViewModel
    @EnvironmentObject private var ordersVM: OrdersViewModel
    @EnvironmentObject private var mainVM: MainViewModel
    
    @FocusState private var isSearchFocused: Bool
    
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
    
    private var sortedOrders: [Order] {
        let orders = getCorrectOrders()
        switch ordersVM.selectedSortOption {
            case .byCostDescending:
                return orders.sorted { $0.totalCost > $1.totalCost }
            case .byCostAscending:
                return orders.sorted { $0.totalCost < $1.totalCost }
            case .byStatus:
                return orders.sorted {
                    let first = ordersVM.statusPriority[$0.status] ?? Int.max
                    let second = ordersVM.statusPriority[$1.status] ?? Int.max
                    return first < second
                }
            case .byType:
                return orders.sorted {
                    let first = ordersVM.typePriority[$0.cargoType] ?? Int.max
                    let second = ordersVM.typePriority[$1.cargoType] ?? Int.max
                    return first < second
                }
        }
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    OrdersTitle(isEmpty: getCorrectOrders().count == 0)
                    
                    ForEach(
                        sortedOrders,
                        id: \.self
                    ) { order in
                        
                        Divider()
                        
                        OrderIdView(order: order)
                        ExpandableOrderView(order: order)
                    }
                }
                .padding()
            }
            .navigationTitle("Logistix")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        ordersVM.isSortSheetPresented = true
                    } label: {
                        Image(systemName: "arrow.up.arrow.down")
                    }
                }
            }
        }
        .searchable(
            text: $ordersVM.searchTerm,
            prompt: "Поиск по № заказа"
        )
        .focused($isSearchFocused)
        .onChange(of: isSearchFocused) { _, focused in
            mainVM.shouldBeHidden = focused
        }
        .onAppear {
            ordersVM.updateOrders()
        }
        .sheet(isPresented: $ordersVM.isSortSheetPresented) {
            VStack(alignment: .leading, spacing: 14) {
                HStack {
                    Image(systemName: "arrow.up.arrow.down")
                    Text("Сортировка")
                        .font(.title3.bold())
                    Spacer()
                }
                .padding(.top, 24)
                .padding(.bottom, 12)

                ForEach(OrdersViewModel.OrdersSortOrder.allCases, id: \.self) { option in
                    Button {
                        ordersVM.selectedSortOption = option
                        ordersVM.isSortSheetPresented = false
                    } label: {
                        HStack {
                            Text(option.rawValue)
                                .foregroundColor(.blue)
                                .lineLimit(1)
                                .truncationMode(.tail)
                            Spacer()
                            if ordersVM.selectedSortOption == option {
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
            .background(Color(.systemBackground))
            .presentationDetents([.fraction(0.45)])
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
