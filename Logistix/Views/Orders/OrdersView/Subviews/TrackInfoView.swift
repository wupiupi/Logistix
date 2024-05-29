//
//  TrackInfoView.swift
//  Logistix
//
//  Created by Serge Broski on 5/22/24.
//

import SwiftUI

struct TrackInfoView: View {
    @EnvironmentObject private var authVM: AuthViewModel
    @EnvironmentObject private var ordersVM: OrdersViewModel
    
    let order: Order
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            Text(order.cargoType)
                .modifier(TitleModifier(font: .title, fontWeight: .bold))
            
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
            
            Text(order.status)
                .font(.title3)
                .foregroundStyle(
                    order.status == "Подтвержден"
                    ? Color(hex: 0x00CCA6, alpha: 1)
                    : .red
                )
                .padding([.top, .bottom], 8)
                .padding([.leading, .trailing], 8)
                .background {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(order.status == "Подтвержден"
                              ? .main.opacity(0.2)
                              : .red.opacity(0.2)
                        )
                }
            
            if authVM.currentUser?.role == Role.admin.rawValue {
                OrderButtonView(
                    title: "Подтвердить заказ",
                    titleColor: .white,
                    backColor: .green) {
                        ordersVM.storageManager.write {
                            order.thaw()?.status = "Подтвержден"
                        }
                    }
                
                OrderButtonView(
                    title: "Отменить",
                    titleColor: .red,
                    backColor: .clear) {
                        ordersVM.storageManager.write {
                            order.thaw()?.status = "Отменен"
                        }
                    }
            }
        }
        .padding()
        .hAlign(.center)
    }
}

#Preview {
    TrackInfoView(
        order: Order()
    )
}
