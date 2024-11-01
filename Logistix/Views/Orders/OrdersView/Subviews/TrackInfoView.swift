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
        NavigationStack {
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
                
                Text(order.status)
                    .font(.title3)
                    .foregroundStyle(
                        order.status == "Отменен"
                        ? .red
                        : Color(hex: 0x00CCA6, alpha: 1)
                    )
                    .padding([.top, .bottom], 8)
                    .padding([.leading, .trailing], 8)
                    .background {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(order.status == "Отменен"
                                  ? .red.opacity(0.2)
                                  : .main.opacity(0.2)
                            )
                    }
                
                if authVM.currentUser?.role == Role.admin.rawValue {
                    switch order.status {
                        case "Завершён":
                            NavigationLink {
                                OrderReportView(order: order)
                            } label: {
                                Text("Посмотреть отчет")
                                    .font(.title2)
                                    .foregroundStyle(.white)
                                    .padding()
                                    .background {
                                        RoundedRectangle(cornerRadius: 12)
                                            .fill(.green)
                                    }
                            }
                        case "Отменен":
                            OrderButtonView(
                                title: "Подтвердить заказ",
                                titleColor: .white,
                                backColor: .green) {
                                    ordersVM.storageManager.write {
                                        order.thaw()?.status = "Подтвержден"
                                    }
                                }
                            
                        case "Подтвержден":
                            OrderButtonView(
                                title: "Завершить",
                                titleColor: .white,
                                backColor: .green) {
                                    ordersVM.storageManager.write {
                                        order.thaw()?.status = "Завершён"
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
                        default:
                            OrderButtonView(
                                title: "Подтвердить",
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
                
                // if you're a driver:
                if authVM.currentUser?.role == Role.driver.rawValue {
                    switch order.status {
                        case "Завершён":
                            NavigationLink {
                                OrderReportView(order: order)
                            } label: {
                                Text("Посмотреть отчет")
                                    .font(.title2)
                                    .foregroundStyle(.white)
                                    .padding()
                                    .background {
                                        RoundedRectangle(cornerRadius: 12)
                                            .fill(.green)
                                    }
                            }
                        case "Отменен":
                        OrderButtonView(
                            title: "Взять в работу",
                            titleColor: .white,
                            backColor: .green) {
                                ordersVM.storageManager.write {
                                    order.thaw()?.status = "В работе"
                                }
                            }
                            
                        case "В работе":
                            OrderButtonView(
                                title: "Завершить",
                                titleColor: .white,
                                backColor: .green) {
                                    ordersVM.storageManager.write {
                                        order.thaw()?.status = "Завершён"
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
                        default:
                            OrderButtonView(
                                title: "Взять в работу",
                                titleColor: .white,
                                backColor: .green) {
                                    ordersVM.storageManager.write {
                                        order.thaw()?.status = "В работе"
                                    }
                                }
                            
                            OrderButtonView(
                                title: "Отказаться",
                                titleColor: .red,
                                backColor: .clear) {
                                    ordersVM.storageManager.write {
                                        order.thaw()?.status = "Отменен"
                                    }
                                }
                    }
                }
            }
        }
        .padding()
        .hAlign(.center)
    }
}
