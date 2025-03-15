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
                    title: "Где забирать груз?",
                    placeholder: "Пример: ул. Зыбицкая, д.1",
                    isInvalid: !newOrderVM.sourceAddress.isEmpty
                    && !newOrderVM.isAddressValid(newOrderVM.sourceAddress)
                )
                
                InputView(
                    text: $newOrderVM.destinationAddress,
                    title: "Куда доставить?",
                    placeholder: "Пример: ул. Пушкинская, д.2",
                    isInvalid: !newOrderVM.destinationAddress.isEmpty
                    && !newOrderVM.isAddressValid(newOrderVM.destinationAddress)
                )
            }
            .hAlign(.center)
        }
        .padding([.leading, .trailing], 16)
    }
}
