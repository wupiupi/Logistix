import SwiftUI

struct InTotalNewOrderView: View {
    @EnvironmentObject private var newOrderVM: NewOrderViewModel
    
    var body: some View {
        VStack(alignment: .center) {
            Text("Итого:")
                .font(.title3)
                .foregroundStyle(.gray)
            
            
            Text("\(newOrderVM.totalCost) BYN")
                .font(.title2)
                .fontWeight(.bold)
        }
        .frame(width: UIScreen.main.bounds.width - 42)
        .padding(.vertical, 25)
        .background {
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(.white)
                .shadow(radius: 10)
        }
        .padding([.leading, .trailing], 16)
        .hAlign(.center)
        
        VStack {
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
        .padding(.bottom, 20)
    }
}
