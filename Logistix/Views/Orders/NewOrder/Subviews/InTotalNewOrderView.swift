import SwiftUI

struct InTotalNewOrderView: View {
    @EnvironmentObject private var newOrderVM: NewOrderViewModel
    
    var body: some View {
        VStack {
            InputView(
                text: $newOrderVM.totalCost,
                title: "Итого:",
                placeholder: "Сумма, которую получит водитель"
            )
            
            Text("Уважаемые пользователи, просим обратить внимание, что комиссия за услуги сервиса составляет 2% от введённой Вами суммы. Таким образом, Вам необходимо заплатить: \(String(format: "%.2f", newOrderVM.costIncludingFee)) BYN")
                .font(.footnote)
                .foregroundStyle(.gray)
                .multilineTextAlignment(.center)
            
            Divider()
            
            Toggle(isOn: $newOrderVM.isAgreededPrivacy) {
                VStack {
                    Text("Согласен(-на) на обработку")
                        .font(.subheadline)
                        .foregroundStyle(.backgroundGray)
                    Text("персональных данных согласно")
                        .font(.subheadline)
                        .foregroundStyle(.backgroundGray)
                    Button {
                        
                    } label: {
                        Text("политике конфиденциальности")
                            .font(.subheadline)
                            .foregroundStyle(.black)
                    }
                }
            }
            .toggleStyle(CheckboxToggleStyle())
        }
        .hAlign(.center)
        .padding([.trailing, .leading], 16)
    }
}
