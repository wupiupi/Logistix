//
//  OrderIdView.swift
//  Logistix
//
//  Created by Serge Broski on 5/22/24.
//

import SwiftUI

struct OrderIdView: View {
    @EnvironmentObject private var ordersVM: OrdersViewModel
    
    let order: Order
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("№ \(order.id)")
                    .font(.title3)
                    .foregroundStyle(
                        ordersVM.getStatusColor(forOrderStatus: order.status).mainColor
                    )
                    .padding([.top, .bottom], 8)
                    .padding([.leading, .trailing], 8)
                    .background {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(
                                ordersVM.getStatusColor(forOrderStatus: order.status).backgroundColor
                            )
                    }
                
                Spacer()
                
                Text(ordersVM.dateFormatter.string(from: order.dateOfLoading))
                    .font(.title3)
            }
        }
    }
}
