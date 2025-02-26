import SwiftUI

struct RegistrationView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Впервые у нас?\nЗарегистрируйся!")
                .multilineTextAlignment(.center)
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 50)
            
            //RegistrationFieldsView()
            
            //RegistrationButtonView()
            
            NavigationLink {
                UserRegistrationView()
            } label: {
                Text("Я ищу водителя!")
                    .modifier(InputViewModifier())
                    .font(.title3)
            }
            
            NavigationLink {
                DriverRegistrationView()
            } label: {
                Text("Я ищу грузы!")
                    .modifier(InputViewModifier())
                    .font(.title3)
            }
        }
        Spacer()
    }
}
