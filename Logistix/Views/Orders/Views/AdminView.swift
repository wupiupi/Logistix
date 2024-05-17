//
//  AdminView.swift
//  Logistix
//
//  Created by Serge Broski on 5/17/24.
//

import SwiftUI
import RealmSwift

struct AdminView: View {
    @EnvironmentObject private var viewModel: AuthViewModel
    
    @State private var toggleStates = ToggleStates()
    @State private var searchTerm = ""
    @State private var isViewExpanded = false

    private let storageManager = StorageManager.shared
    @ObservedResults(Order.self) var orders
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter
    }()
    
    private var userOrders: [Order] {
        orders.filter { $0.userID == viewModel.currentUser?.id ?? ""}
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    
                    Text("Все заказы")
                        .foregroundStyle(Color(hex: 0x363746, alpha: 1))
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                    
                    ForEach(userOrders, id: \.self) { order in
                        
                        Divider()
                        
                        VStack(alignment: .leading) {
                            // Order ID & Date of Loading
                            HStack {
                                Text("№ \(order.id)")
                                    .font(.title3)
                                    .foregroundStyle(Color(hex: 0x00CCA6, alpha: 1))
                                    .padding([.top, .bottom], 8)
                                    .padding([.leading, .trailing], 8)
                                    .background {
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(.main.opacity(0.2))
                                    }
                                
                                Spacer()
                                
                                Text(dateFormatter.string(from: order.dateOfLoading))
                                    .font(.title3)
                            }
                            
                            ExpandableView(
                                thumbnail: ThumbnailView(content: {
                                    VStack {
                                        Text("Доставка \(order.cargoType)")
                                            .foregroundStyle(Color.init(hex: 0x363746))
                                            .font(.title)
                                            .fontWeight(.bold)
                                    }
                                    .padding()
                                }),
                                expanded: ExpandedView(content: {
                                    VStack(alignment: .center, spacing: 20) {
                                        Text("Доставка \(order.cargoType)")
                                            .foregroundStyle(Color.init(hex: 0x363746))
                                            .font(.title)
                                            .fontWeight(.bold)
                                        
                                        TrackDetail(
                                            title: "Адрес отправителя",
                                            orderInfo: order.sourceAddress
                                        )
                                        TrackDetail(
                                            title: "Адрес получателя",
                                            orderInfo: order.destinationAddress
                                        )
                                        TrackDetail(
                                            title: "Поставщик",
                                            orderInfo: order.senderName
                                        )
                                        TrackDetail(
                                            title: "Контактный телефон",
                                            orderInfo: order.senderPhoneNumber
                                        )
                                        TrackDetail(
                                            title: "Трек номер",
                                            orderInfo: order.trackingNumber,
                                            systemImage: "doc.on.doc.fill"
                                        )
                                        TrackDetail(
                                            title: "Стоимость",
                                            orderInfo: order.totalCost
                                        )
                                        
                                        Text("Статус заказа")
                                            .font(.title3)
                                            .foregroundStyle(.gray)
                                        
                                        Text(order.status)
                                            .font(.title3)
                                            .foregroundStyle(
                                                Color(
                                                    hex: 0x00CCA6,
                                                    alpha: 1
                                                )
                                            )
                                            .padding([.top, .bottom], 8)
                                            .padding([.leading, .trailing], 8)
                                            .background {
                                                RoundedRectangle(cornerRadius: 10)
                                                    .fill(.main.opacity(0.2))
                                            }
                                        
                                        Button("Подтвердить", action: { order.status = "Подтверждено" })
                                        Button("Отклонить", action: { order.status = "Отклонено" })
                                    }
                                    .padding()
                                    .hAlign(.center)
                                })
                            )
                        }
                    }
                }
                .padding()
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
        }
    }
}

#Preview {
    AdminView()
}
