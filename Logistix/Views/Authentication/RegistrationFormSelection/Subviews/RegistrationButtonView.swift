import SwiftUI

struct RegistrationButtonView: View {
    @EnvironmentObject private var authVM: AuthViewModel
    @EnvironmentObject private var registrationVM: RegistrationViewModel
    
    var body: some View {
        Button {
            Task {
                let auto = Auto(
                    brand: registrationVM.autoBrand,
                    maxWeightLimit: registrationVM.autoMaxWeight,
                    regNumber: registrationVM.autoRegNumber
                )
                try await authVM.createUser(
                    withEmail: registrationVM.email,
                    password: registrationVM.password,
                    fullName: registrationVM.fullName,
                    role: registrationVM.autoBrand == ""
                    ? Role.user.rawValue
                    : Role.driver.rawValue,
                    auto: auto
                )
            }
        } label: {
            Text("Зарегистрироваться")
                .foregroundStyle(.white)
                .font(.title2)
                .fontWeight(.semibold)
                .background {
                    RoundedRectangle(cornerRadius: CornerRadius.rectangle.rawValue)
                        .frame(
                            width: UIScreen.main.bounds.width - 64,
                            height: 50
                        )
                        .foregroundStyle(.greenButton)
                }
                .disabled(!registrationVM.formIsValid)
                .opacity(registrationVM.formIsValid ? 1.0 : 0.5)
        }
        .alert(authVM.alertMessage, isPresented: $authVM.isEmailTaken, actions: {} )
    }
}
