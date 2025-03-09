import SwiftUI

struct RegistrationFieldsView: View {
    @EnvironmentObject private var authVM: AuthViewModel
    @EnvironmentObject private var registrationVM: RegistrationViewModel
    
    var body: some View {
        VStack(spacing: 12) {
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
                
                VStack(alignment: .trailing) {
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
                .hAlign(.trailing)
            }
        }
        .padding([.leading, .trailing, .bottom], 16)
    }
}
