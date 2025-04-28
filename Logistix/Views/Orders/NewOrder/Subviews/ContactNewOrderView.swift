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
                    placeholder: "Иванов Иван Иванович",
                    isInvalid: !newOrderVM.senderName.isEmpty
                    && !newOrderVM.isNameValid(newOrderVM.senderName)
                )
                
                InputView(
                    text: $newOrderVM.senderPhoneNumber,
                    title: "Телефон:",
                    placeholder: "+375XXXXXXXXX или 80ХХХХХХХХХ",
                    isInvalid: !newOrderVM.senderPhoneNumber.isEmpty
                    && !newOrderVM.isPhoneValid(newOrderVM.senderPhoneNumber)
                )
                
                InputView(
                    text: $newOrderVM.recipientName,
                    title: "Получатель:",
                    placeholder: "Иванов Иван Иванович",
                    isInvalid: !newOrderVM.recipientName.isEmpty
                    && !newOrderVM.isNameValid(newOrderVM.recipientName)
                )
                
                InputView(
                    text: $newOrderVM.recipientPhoneNumber,
                    title: "Телефон:",
                    placeholder: "+375XXXXXXXXX или 80ХХХХХХХХХ",
                    isInvalid: !newOrderVM.recipientPhoneNumber.isEmpty && !newOrderVM.isPhoneValid(newOrderVM.recipientPhoneNumber)
                )
            }
            .hAlign(.center)
        }
        .padding([.leading, .trailing], 16)
    }
}
