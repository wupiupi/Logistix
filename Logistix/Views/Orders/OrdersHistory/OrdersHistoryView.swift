//
//  OrdersHistoryView.swift
//  Logistix
//
//  Created by Paul Makey on 16.11.24.
//

import SwiftUI

struct OrdersHistoryView: View {
    @EnvironmentObject private var authVM: AuthViewModel
    @EnvironmentObject private var ordersVM: OrdersViewModel
    
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
            .toolbarBackground(
                LinearGradient(
                    colors: [
                        Color(hex: 0x00CCA6, alpha: 1),
                        Color(hex: 0x29B197, alpha: 0.5)
                    ],
                    startPoint: .leading,
                    endPoint: .trailing
                ),
                for: .navigationBar
            )
        }
        .searchable(
            text: $ordersVM.searchTerm,
            prompt: "Поиск по документам или заказам"
        )
    }
}
