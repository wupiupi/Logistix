//
//  OrdersView.swift
//  Logistix
//
//  Created by Paul Makey on 12.05.24.
//

import SwiftUI
import RealmSwift

struct OrdersView: View {
    // Wrappers
    @EnvironmentObject private var viewModel: AuthViewModel
    @ObservedResults(Order.self) var orders
    
    @State private var searchTerm = ""
    @State private var isViewExpanded = false
    
    private let storageManager = StorageManager.shared
    
    // Computing Properties
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
                        .modifier(TitleModifier(font: .largeTitle, fontWeight: .semibold))
                    
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
                                            .modifier(
                                                TitleModifier(
                                                    font: .title,
                                                    fontWeight: .semibold
                                                )
                                            )
                                    }
                                    .padding()
                                }),
                                expanded: ExpandedView(content: {
                                    VStack(alignment: .center, spacing: 20) {
                                        Text(order.cargoType)
                                            .modifier(TitleModifier(font: .title, fontWeight: .bold))
                                        
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
                                            systemImageName: "doc.on.doc.fill"
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
                                        
                                        if viewModel.currentUser?.role == Role.admin.rawValue {
                                            Button {
                                                storageManager.write {
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
                                            
                                            Button {
                                                storageManager.write {
                                                    order.thaw()?.status = "Отменен"
                                                }
                                                //   $orders.remove(order)
                                            } label: {
                                                Text("Отменить")
                                                    .font(.title2)
                                                    .foregroundStyle(.red)
                                                    .padding()
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

// MARK: - TitleModifier
struct TitleModifier: ViewModifier {
    let font: Font
    let fontWeight: Font.Weight
    
    func body(content: Content) -> some View {
        content
            .foregroundStyle(Color(hex: 0x363746, alpha: 1))
            .font(font)
            .fontWeight(fontWeight)
    }
}

// MARK: - TrackDetail
struct TrackDetail: View {
    let title: String
    let orderInfo: String
    var systemImageName: String? = nil
    
    var body: some View {
        Text(title)
            .font(.title3)
            .foregroundStyle(.gray)
        
        HStack {
            if let systemImageName {
                Image(systemName: systemImageName)
            }
            
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
