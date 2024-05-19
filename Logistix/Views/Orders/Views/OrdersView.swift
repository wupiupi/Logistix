//
//  OrdersView.swift
//  Logistix
//
//  Created by Paul Makey on 12.05.24.
//

import SwiftUI
import RealmSwift

struct ToggleStates {
    var oneIsOn: Bool = false
    var twoIsOn: Bool = true
}

struct OrdersView: View {
    //    @EnvironmentObject private var viewModel: OrdersViewModel
    @EnvironmentObject private var viewModel: AuthViewModel
    
    @State private var toggleStates = ToggleStates()
    @State private var searchTerm = ""
    @State private var isViewExpanded = false
    
    private let storageManager = StorageManager.shared
    @ObservedResults(Order.self) var orders
    
    private var filteredOrders: [Order] {
        guard !searchTerm.isEmpty else { return Array(orders) }
        return orders.filter { $0.trackingNumber.localizedCaseInsensitiveContains(searchTerm) }
    }
    
    private var userOrders: [Order] {
        filteredOrders.filter { $0.userID == viewModel.currentUser?.id ?? ""}
    }
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter
    }()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    
                    Text("Текущие заказы")
                        .foregroundStyle(Color(hex: 0x363746, alpha: 1))
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                    
                    // Sorting
                    /*
                     ForEach(orders, id: \.self) { order in
                     DisclosureGroup("Сортировать", isExpanded: $isViewExpanded) {
                     HStack {
                     Image(systemName: "calendar")
                     .foregroundStyle(.main)
                     
                     Text(dateFormatter.string(from: order.dateOfLoading))
                     Text("–")
                     
                     Image(systemName: "calendar")
                     .foregroundStyle(.main)
                     
                     Text(dateFormatter.string(from: order.dateOfDelivery))
                     }
                     .font(.title3)
                     }
                     .disclosureGroupStyle(CustomDisclosureStyle())
                     }
                     */
                    
                    ForEach(
                        viewModel.currentUser?.role == Role.user.rawValue ? userOrders : filteredOrders,
                        id: \.self
                    ) { order in
                        
                        Divider()
                        
                        VStack(alignment: .leading) {
                            // Order ID & Date of Loading
                            HStack {
                                Text("№ \(order.trackingNumber)")
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
                                        Text(order.cargoType)
                                            .foregroundStyle(Color.init(hex: 0x363746))
                                            .font(.title)
                                            .fontWeight(.bold)
                                    }
                                    .padding()
                                }),
                                expanded: ExpandedView(content: {
                                    VStack(alignment: .center, spacing: 20) {
                                        Text(order.cargoType)
                                            .foregroundStyle(Color.init(hex: 0x363746))
                                            .font(.title)
                                            .fontWeight(.bold)
                                        
                                        TrackDetail(
                                            title: "Адрес отправителя",
                                            orderInfo: order.route?.sourceAddress ?? ""
                                        )
                                        TrackDetail(
                                            title: "Адрес получателя",
                                            orderInfo: order.route?.destinationAddress ?? ""
                                        )
                                        TrackDetail(
                                            title: "Поставщик",
                                            orderInfo: order.sender?.name ?? ""
                                        )
                                        TrackDetail(
                                            title: "Контактный телефон",
                                            orderInfo: order.sender?.phoneNumber ?? ""
                                        )
                                        TrackDetail(
                                            title: "Трек номер",
                                            orderInfo: order.trackingNumber,
                                            systemImage: "doc.on.doc.fill"
                                        )
                                        TrackDetail(
                                            title: "Стоимость",
                                            orderInfo: order.price?.totalCost ?? ""
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
                                        
                                        if viewModel.currentUser?.role == Role.admin.rawValue {
                                            Button {
                                                try! Realm().write {
                                                    order.thaw()?.status = "Подтвержден"
                                                }
                                            } label: {
                                                Text("Подтвердить заказ")
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
            
            .searchable(
                text: $searchTerm,
                prompt: "Поиск по документам или заказам"
            )
        }
    }
}

struct TrackDetail: View {
    let title: String
    let orderInfo: String
    var systemImage = ""
    
    var body: some View {
        Text(title)
            .font(.title3)
            .foregroundStyle(.gray)
        
        HStack {
            Image(systemName: systemImage)
            
            if title == "Стоимость" {
                Text("\(orderInfo) BYN")
                    .font(.title3)
                    .foregroundStyle(.black)
            } else {
                Text(orderInfo)
                    .font(.title3)
                    .foregroundStyle(.black)
            }
        }
    }
}

// MARK: - CustomDisclosureStyle
struct CustomDisclosureStyle: DisclosureGroupStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack {
            Button {
                withAnimation(.linear) {
                    configuration.isExpanded.toggle()
                }
            } label: {
                HStack(alignment: .firstTextBaseline) {
                    /// - Configuring Text
                    configuration.label
                        .foregroundStyle(Color(hex: 0x363746, alpha: 1))
                        .font(.title2)
                    
                    Spacer()
                    
                    /// - Configuring Image
                    Image(systemName: configuration.isExpanded ? "chevron.up" : "chevron.down")
                        .foregroundColor(Color(hex: 0x9495AA))
                        .font(.caption.lowercaseSmallCaps())
                        .animation(nil, value: configuration.isExpanded)
                }
                .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
            .padding(.bottom, 20)
            if configuration.isExpanded {
                configuration.content
            }
        }
    }
}

//#Preview {
//    OrdersView()
//}

