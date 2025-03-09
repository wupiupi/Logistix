import SwiftUI

struct CarrierNewOrderView: View {
    @EnvironmentObject private var newOrderVM: NewOrderViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            VStack(alignment: .leading) {
                Text("Что везём")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundStyle(.text)
                
                Text("Тип вложения")
                    .font(.headline)
                    .foregroundStyle(.gray)
                
                Picker("Тип вложения", selection: $newOrderVM.cargoType) {
                    ForEach(NewOrderViewModel.CargoType.allCases, id: \.self) {
                        Text($0.rawValue)
                    }
                }
                .tint(.white)
                .frame(
                    width: UIScreen.main.bounds.width - 32,
                    height: 40
                )
                .background {
                    RoundedRectangle(cornerRadius: CornerRadius.rectangle.rawValue)
                        .fill(.picker)
                }
                .hAlign(.center)
            }
            .padding([.leading, .trailing], 16)
            
            Text("Вес:")
                .foregroundStyle(.gray)
                .font(.headline)
                .padding(.leading, 16)
            
            Picker("", selection: $newOrderVM.selectedWeight) {
                ForEach(NewOrderViewModel.Weight.allCases, id: \.self) {
                    Text($0.rawValue)
                }
            }
            .pickerStyle(.segmented)
        }
    }
}
