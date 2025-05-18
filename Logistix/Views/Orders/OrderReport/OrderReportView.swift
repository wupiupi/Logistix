import SwiftUI

struct OrderReportView: View {
    @Environment(\.dismiss) var dismiss
    let order: Order
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter
    }()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
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
                
                VStack {
                    Text("Статус заказа")
                        .font(.title3)
                        .foregroundStyle(.gray)
                    
                    Text("\(order.status): \(dateFormatter.string(from: Date.now))")
                        .font(.title3)
                        .foregroundStyle(.text)
                        .padding([.top, .bottom], 8)
                        .padding([.leading, .trailing], 8)
                }
                .hAlign(.center)
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
