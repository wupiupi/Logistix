import SwiftUI

struct RouteNewOrderView: View {
    @EnvironmentObject private var newOrderVM: NewOrderViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Маршрут")
                .font(.title3)
                .fontWeight(.bold)
                .foregroundStyle(.text)
            
            VStack {
                InputView(
                    text: $newOrderVM.sourceAddress,
                    title: "Откуда:",
                    placeholder: "Адрес отправки"
                )
                
                InputView(
                    text: $newOrderVM.destinationAddress,
                    title: "Куда:",
                    placeholder: "Адрес доставки"
                )
            }
            .hAlign(.center)
        }
        .padding([.leading, .trailing], 16)
    }
}
