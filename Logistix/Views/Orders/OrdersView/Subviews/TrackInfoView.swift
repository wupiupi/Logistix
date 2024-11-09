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
    
    var order: Order
    
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
                    orderInfo: order.sourceAddress
                )
                OrderDetailsView(
                    title: "Адрес получателя",
                    orderInfo: order.destinationAddress
                )
                OrderDetailsView(
                    title: "Поставщик",
                    orderInfo: order.senderName
                )
                OrderDetailsView(
                    title: "Контактный телефон",
                    orderInfo: order.senderPhoneNumber
                )
                OrderDetailsView(
                    title: "Стоимость",
                    orderInfo: order.totalCost
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
                
                if authVM.currentUser?.role == "admin" {
                    switch order.status {
                        case OrderStatus.finished.rawValue:
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
                        case OrderStatus.cancelled.rawValue:
                            OrderButtonView(
                                title: ButtonAction.confirm.rawValue,
                                titleColor: .white,
                                backColor: .green) {
                                    Task {
                                        await ordersVM.updateOrderStatus(
                                            forOrderID: order.id,
                                            status: OrderStatus.searchingForDriver.rawValue
                                        )
                                    }
                                }
                            OrderButtonView(
                                title: ButtonAction.delete.rawValue,
                                titleColor: .red,
                                backColor: .clear) {
                                    Task {
                                        await ordersVM.deleteOrder(withID: order.id)
                                    }
                                }
                        case OrderStatus.searchingForDriver.rawValue:
                            OrderButtonView(
                                title: ButtonAction.cancel.rawValue,
                                titleColor: .red,
                                backColor: .clear) {
                                    Task {
                                        await ordersVM.updateOrderStatus(
                                            forOrderID: order.id,
                                            status: OrderStatus.cancelled.rawValue
                                        )
                                    }
                                }
                        default:
                            OrderButtonView(
                                title: ButtonAction.confirm.rawValue,
                                titleColor: .white,
                                backColor: .green) {
                                    Task {
                                        await ordersVM.updateOrderStatus(
                                            forOrderID: order.id,
                                            status: OrderStatus.searchingForDriver.rawValue
                                        )
                                    }
                                }
                            
                            OrderButtonView(
                                title: ButtonAction.cancel.rawValue,
                                titleColor: .red,
                                backColor: .clear) {
                                    Task {
                                        await ordersVM.updateOrderStatus(
                                            forOrderID: order.id,
                                            status: OrderStatus.cancelled.rawValue
                                        )
                                    }
                                }
                    }
                } else if authVM.currentUser?.role == Role.driver.rawValue {
                    switch order.status {
                        case OrderStatus.searchingForDriver.rawValue:
                            OrderButtonView(
                                title: ButtonAction.assignJob.rawValue,
                                titleColor: .white,
                                backColor: .green) {
                                    Task {
                                        await ordersVM.assignDriverToOrder(
                                            forOrderID: order.id,
                                            driverID: authVM.currentUser?.id ?? ""
                                        )
                                        await ordersVM.updateOrderStatus(
                                            forOrderID: order.id,
                                            status: OrderStatus.inProcess.rawValue
                                        )
                                    }
                                }
                        case OrderStatus.inProcess.rawValue:
                            OrderButtonView(
                                title: ButtonAction.complete.rawValue,
                                titleColor: .white,
                                backColor: .green) {
                                    var updatedOrder = order
                                    updatedOrder.status = OrderStatus.finished.rawValue
                                    Task {
                                        await ordersVM.updateOrderStatus(
                                            forOrderID: order.id,
                                            status: OrderStatus.finished.rawValue
                                        )
                                        await authVM.addOrderToUser(order: updatedOrder)
                                    }
                                }
                            OrderButtonView(
                                title: ButtonAction.cancel.rawValue,
                                titleColor: .red,
                                backColor: .clear) {
                                    Task {
                                        await ordersVM.updateOrderStatus(
                                            forOrderID: order.id,
                                            status: OrderStatus.cancelled.rawValue)
                                    }
                                }
                        default:
                            // TODO: - SAVE TO DRIVER ORDERS
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
                    }
                }
            }
        }
        .padding()
        .hAlign(.center)
    }
}

