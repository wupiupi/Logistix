import SwiftUI

struct ContactNewOrderView: View {
    @EnvironmentObject private var newOrderVM: NewOrderViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Контактные данные")
                .font(.title3)
                .fontWeight(.bold)
                .foregroundStyle(.text)
            
            VStack {
                InputView(
                    text: $newOrderVM.senderName,
                    title: "Отправитель:",
                    placeholder: "Иванов Иван Иванович"
                )
                
                InputView(
                    text: $newOrderVM.senderPhoneNumber,
                    title: "Телефон:",
                    placeholder: "+375(XX)XXX-XX-XX"
                )
                
                InputView(
                    text: $newOrderVM.recipientName,
                    title: "Получатель:",
                    placeholder: "Иванов Иван Иванович"
                )
                
                InputView(
                    text: $newOrderVM.recipientPhoneNumber,
                    title: "Телефон:",
                    placeholder: "+375(XX)XXX-XX-XX"
                )
            }
            .hAlign(.center)
        }
        .padding([.leading, .trailing], 16)
    }
}
