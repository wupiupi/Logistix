import SwiftUI

struct PaymentMethodNewOrderView: View {
    @EnvironmentObject private var newOrderVM: NewOrderViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Способ оплаты")
                .font(.title)
                .fontWeight(.bold)
                .foregroundStyle(.text)
                .padding(.leading)
            
            Text("Выберите способ оплаты:")
                .foregroundStyle(.text)
                .font(.title3)
                .padding(.leading)
            
            Picker("", selection: $newOrderVM.payment) {
                ForEach(NewOrderViewModel.Payment.allCases, id: \.self) {
                    Text($0.rawValue)
                }
            }
            .pickerStyle(.segmented)
        }
        .padding(.bottom, 20)
    }
}
