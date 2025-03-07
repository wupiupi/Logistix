import SwiftUI

struct PaymentMethodNewOrderView: View {
    @EnvironmentObject private var newOrderVM: NewOrderViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                Text("Способ оплаты")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundStyle(.text)
                
                Text("Выберите способ оплаты:")
                    .font(.headline)
                    .foregroundStyle(.gray)
            }
            .hAlign(.leading)
            .padding([.leading, .trailing], 16)
            
            Picker("", selection: $newOrderVM.payment) {
                ForEach(NewOrderViewModel.Payment.allCases, id: \.self) {
                    Text($0.rawValue)
                }
            }
            .pickerStyle(.segmented)
        }
    }
}
