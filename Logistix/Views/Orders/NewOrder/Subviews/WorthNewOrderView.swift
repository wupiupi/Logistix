import SwiftUI

struct WorthNewOrderView: View {
    @EnvironmentObject private var newOrderVM: NewOrderViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Ценность груза")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundStyle(.text)
                
                Text("BYN")
                    .font(.footnote)
                    .fontWeight(.semibold)
                    .foregroundStyle(.gray)
                    .padding([.top, .leading], -4)
            }
            
            InputView(
                text: $newOrderVM.cargoCost,
                title: "",
                placeholder: "Ценность груза",
                isNumPad: true
            )
            
            Text("Компенсируем ценность поврежденного груза в течении трех рабочих дней. Максимальная компенсация – 3000 BYN")
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .foregroundStyle(.gray)
        }
        .hAlign(.center)
        .padding([.leading, .trailing], 16)
    }
}
