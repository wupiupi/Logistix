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
    var realmImage: RealmImage? {
        ordersVM.fetchOrderFromRealm(imageID: order.imageID)
    }
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .center, spacing: 20) {
                Text(order.cargoType)
                    .modifier(
                        TitleModifier(
                            font: .title,
                            fontWeight: .bold,
                            color: Color.expandableViewMain
                        )
                    )
                
                if let realmImage, let imageData = realmImage.data, let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200)
                } else {
                    Text("Нет фото")
                }
                                
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
                if authVM.currentUser?.role == Role.admin.rawValue {
                    OrderDetailsView(
                        title: "Создано пользователем с ID:",
                        orderInfo: order.userID
                    )
                }
                
                Text("Статус заказа")
                    .font(.title3)
                    .foregroundStyle(.gray)
                
                Text(order.status)
                    .font(.title3)
                    .foregroundStyle(
                        ordersVM.getStatusColor(forOrderStatus: order.status).mainColor
                    )
                    .padding([.top, .bottom], 8)
                    .padding([.leading, .trailing], 8)
                    .background {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(
                                ordersVM.getStatusColor(
                                    forOrderStatus: order.status
                                ).backgroundColor
                            )
                    }
                
                Divider()
                
                if authVM.currentUser?.role == "admin" {
                    switch order.status {
                        case OrderStatus.completed.rawValue:
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
                            OrderButtonView(
                                title: ButtonAction.delete.rawValue,
                                titleColor: .red,
                                backColor: .clear) {
                                    Task {
                                        await ordersVM.deleteOrder(withID: order.id)
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
                        case OrderStatus.searchingForDriver.rawValue,
                            OrderStatus.inProcess.rawValue:
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
                                    updatedOrder.status = OrderStatus.completed.rawValue
                                    Task {
                                        await ordersVM.updateOrderStatus(
                                            forOrderID: order.id,
                                            status: OrderStatus.completed.rawValue
                                        )
                                        await authVM.addOrderToUser(order: updatedOrder)
                                    }
                                }
                            OrderButtonView(
                                title: ButtonAction.refuse.rawValue,
                                titleColor: .red,
                                backColor: .clear) {
                                    Task {
                                        await ordersVM.updateOrderStatus(
                                            forOrderID: order.id,
                                            status: OrderStatus.searchingForDriver.rawValue)
                                        await ordersVM.removeDriverFromOrder(
                                            forOrderID: order.id
                                        )
                                    }
                                }
                        default:
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
                } else if authVM.currentUser?.role == Role.user.rawValue
                            && order.userID == authVM.currentUser?.id
                            && order.status == OrderStatus.onModeration.rawValue {
                    OrderButtonView(
                        title: ButtonAction.delete.rawValue,
                        titleColor: .red,
                        backColor: .clear) {
                            Task {
                                await ordersVM.deleteOrder(withID: order.id)
                            }
                        }
                }
            }
        }
        .padding()
        .hAlign(.center)
    }
}

