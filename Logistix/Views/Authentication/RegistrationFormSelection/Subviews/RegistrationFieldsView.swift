import SwiftUI

struct RegistrationFieldsView: View {
    @EnvironmentObject private var authVM: AuthViewModel
    @EnvironmentObject private var registrationVM: RegistrationViewModel
    
    var body: some View {
        InputView(
            text: $registrationVM.email,
            title: "Почта",
            placeholder: "Example@gmail.com"
        )
        .textInputAutocapitalization(.never)
        
        InputView(
            text: $registrationVM.fullName,
            title: "Имя",
            placeholder: "Иванов Иван Иванович"
        )
        
        InputView(
            text: $registrationVM.password,
            title: "Пароль",
            placeholder: "Пароль",
            isSecureField: true
        )
        .onAppear {
            // Clearing fields so that the next time this view appears, the entered data will not remain
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
                isSecureField: true
            )
            
            if !registrationVM.password.isEmpty
                && !registrationVM.confirmPassword.isEmpty {
                if registrationVM.password == registrationVM.confirmPassword {
                    Image(systemName: "checkmark.circle.fill")
                        .imageScale(.large)
                        .fontWeight(.bold)
                        .foregroundStyle(.green)
                } else {
                    Image(systemName: "xmark.circle.fill")
                        .imageScale(.large)
                        .fontWeight(.bold)
                        .foregroundStyle(.red)
                }
            }
        }
        .padding(.bottom, 20)
    }
}
