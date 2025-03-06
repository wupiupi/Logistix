import SwiftUI

struct OrdersTitle: View {
    var title: String? = nil
    var isEmpty: Bool = false
    
    var body: some View {
        VStack {
            Text(isEmpty ? "Пока что заказов нет" : title ?? "Текущие заказы")
                .modifier(
                    TitleModifier(
                        font: .title,
                        fontWeight: .semibold,
                        color: .text
                    )
                )
        }
        .hAlign(.center)
    }
}
