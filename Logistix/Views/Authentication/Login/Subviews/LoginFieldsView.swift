import SwiftUI

struct LoginFieldsView: View {
    @EnvironmentObject private var loginVM: LoginViewModel
    
    var body: some View {
        VStack {
            InputView(
                text: $loginVM.email,
                title: "Почта",
                placeholder: "Example@gmail.com",
                isInvalid: !loginVM.email.isEmpty && !loginVM.isEmailValid
            )
            .textInputAutocapitalization(.never)
            
            InputView(
                text: $loginVM.password,
                title: "Пароль",
                placeholder: "Пароль",
                isSecureField: true,
                isInvalid: !loginVM.password.isEmpty && !loginVM.isPasswordValid
            )
            .padding(.bottom, 20)
            .onAppear {
                // Clearing fields so that the next time this view appears, the entered data will not remain
                loginVM.email = ""
                loginVM.password = ""
            }
        }
        .padding([.leading, .trailing], 16)
    }
}
