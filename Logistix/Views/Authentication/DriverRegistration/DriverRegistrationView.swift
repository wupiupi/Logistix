import SwiftUI

struct DriverRegistrationView: View {
    @EnvironmentObject private var registrationVM: RegistrationViewModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("Форма регистрации для водителей")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundStyle(.black)
                
                Text("Регистрируйтесь и смотрите,\nкакие заказы сейчас доступны!")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundStyle(.gray)
                    .multilineTextAlignment(.center)
                
                RegistrationFieldsView()
                    .padding(.bottom, -5)
                
                VStack {
                    InputView(
                        text: $registrationVM.autoBrand,
                        title: "Марка авто",
                        placeholder: "BMW, Mercedes"
                    )
                    
                    InputView(
                        text: $registrationVM.autoMaxWeight,
                        title: "Максимально допустимый вес",
                        placeholder: "xxx кг"
                    )
                    
                    InputView(
                        text: $registrationVM.autoRegNumber,
                        title: "Регистрационный номер",
                        placeholder: "1111XX-X"
                    )
                }
                .padding([.leading, .trailing], 16)
                .padding(.bottom, 6)
                
                RegistrationButtonView()
            }
        }
        .scrollIndicators(.hidden)
    }
}
