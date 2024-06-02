//
//  OrderReportView.swift
//  Logistix
//
//  Created by Paul Makey on 2.06.24.
//

import SwiftUI

struct OrderReportView: View {
    @Environment(\.dismiss) var dismiss
    let order: Order
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 20) {
                Text(order.cargoType)
                    .modifier(
                        TitleModifier(
                            font: .title,
                            fontWeight: .bold,
                            color: Color(hex: 0x363746, alpha: 1)
                        )
                    )
                
                OrderDetailsView(
                    title: "Адрес отправителя",
                    orderInfo: order.route?.sourceAddress ?? ""
                )
                OrderDetailsView(
                    title: "Адрес получателя",
                    orderInfo: order.route?.destinationAddress ?? ""
                )
                OrderDetailsView(
                    title: "Поставщик",
                    orderInfo: order.sender?.name ?? ""
                )
                OrderDetailsView(
                    title: "Контактный телефон",
                    orderInfo: order.sender?.phoneNumber ?? ""
                )
                OrderDetailsView(
                    title: "Трек номер",
                    orderInfo: order.trackingNumber,
                    systemImageName: "doc.on.doc.fill"
                )
                OrderDetailsView(
                    title: "Стоимость",
                    orderInfo: order.price?.totalCost ?? ""
                )
                
                Text("Статус заказа")
                    .font(.title3)
                    .foregroundStyle(.gray)
                
                Text("\(order.status): \(Date().formatted())")
                    .font(.title3)
                    .foregroundStyle(Color(hex: 0x00CCA6, alpha: 1))
                    .padding([.top, .bottom], 8)
                    .padding([.leading, .trailing], 8)
                    .background {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.main.opacity(0.2))
                    }
            }
            .padding(.top, 30)
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            Button {
                dismiss()
            } label: {
                Text("Готово")
            }
        }
        .scrollIndicators(.hidden)
        .padding()
        .hAlign(.center)
    }
}
