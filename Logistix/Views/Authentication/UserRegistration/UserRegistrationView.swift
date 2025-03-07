import SwiftUI

struct UserRegistrationView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Есть товар, но некому доставить?")
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundStyle(.black)
            
            Text("Регистрируйтесь и размещайте\nВаши предложения!")
                .multilineTextAlignment(.center)
                .font(.headline)
                .fontWeight(.bold)
                .foregroundStyle(.gray)
            
            RegistrationFieldsView()
            RegistrationButtonView()
            
            Spacer()
        }
    }
}
