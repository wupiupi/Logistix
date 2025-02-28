import SwiftUI

struct OrdersTitle: View {
    var title: String? = nil
    var isEmpty: Bool = false
    
    var body: some View {
        Text(isEmpty ? "Пока что заказов нет" : title ?? "Текущие заказы")
            .modifier(
                TitleModifier(
                    font: .largeTitle,
                    fontWeight: .semibold,
                    color: Color(hex: 0x363746, alpha: 1)
                )
            )
    }
}
