//
//  NewOrderView.swift
//  Logistix
//
//  Created by Paul Makey on 13.05.24.
//

import SwiftUI

struct NewOrderView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    // MARK: - Header
                    HeaderNewOrderView()
                    
                    Divider()
                    
                    // MARK: - Route
                    RouteNewOrderView()
                    
                    Divider()
                    
                    // MARK: - Contact info
                    ContactNewOrderView()
                    
                    Divider()
                    
                    // MARK: - Carrier info
                    CarrierNewOrderView()
                    
                    Divider()
                    
                    // MARK: - Estimated time
                    EstimatedTimeNewOrderView()
                    
                    Divider()
                    
                    // MARK: - Worth of order
                    WorthNewOrderView()
                    
                    Divider()
                    
                    // MARK: - Payment method
                    PaymentMethodNewOrderView()
                    
                    Divider()
                    
                    // MARK: - In total
                    InTotalNewOrderView()
                    
                    // MARK: - Create order button
                    CreateNewOrderButtonView()
                }
                .navigationTitle("Logistix")
            }
        }
    }
}

#Preview {
    NewOrderView()
        .environmentObject(NewOrderViewModel(selectedWeight: .belowOneHundred))
        .environmentObject(AuthViewModel())
}
