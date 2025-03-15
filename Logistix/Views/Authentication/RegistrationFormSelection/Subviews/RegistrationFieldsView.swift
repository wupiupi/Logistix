import SwiftUI

struct RegistrationFieldsView: View {
    @EnvironmentObject private var authVM: AuthViewModel
    @EnvironmentObject private var registrationVM: RegistrationViewModel
    
    var body: some View {
        VStack(spacing: 12) {
            InputView(
                text: $registrationVM.email,
                title: "Почта",
                placeholder: "Example@gmail.com",
                isInvalid: !registrationVM.email.isEmpty
                && !registrationVM.isEmailValid
            )
            .textInputAutocapitalization(.never)
            
            InputView(
                text: $registrationVM.fullName,
                title: "Имя",
                placeholder: "Иванов Иван Иванович",
                isInvalid: !registrationVM.fullName.isEmpty
                && !registrationVM.isFullNameValid
            )
            
            InputView(
                text: $registrationVM.password,
                title: "Пароль",
                placeholder: "Пароль",
                isSecureField: true,
                isInvalid: !registrationVM.password.isEmpty
                && !registrationVM.isPasswordValid
            )
            .onAppear {
                registrationVM.email = ""
                registrationVM.password = ""
                registrationVM.fullName = ""
                registrationVM.confirmPassword = ""
                registrationVM.autoBrand = ""
                registrationVM.autoMaxWeight = ""
                registrationVM.autoRegNumber = ""
            }
            
            ZStack {
                InputView(
                    text: $registrationVM.confirmPassword,
                    title: "Подтвердить пароль",
                    placeholder: "Подтвердите пароль",
                    isSecureField: true,
                    isInvalid: !registrationVM.confirmPassword.isEmpty
                    && !registrationVM.isConfirmPasswordValid
                )
            }
        }
        .padding([.leading, .trailing, .bottom], 16)
    }
}
