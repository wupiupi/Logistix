import SwiftUI

struct LoginButtonView: View {
    @EnvironmentObject private var authVM: AuthViewModel
    @EnvironmentObject private var loginVM: LoginViewModel

    @State private var showResetAlert = false
    @State private var resetEmail = ""
    @State private var resetMessage = ""
    @State private var showResetMessage = false

    var body: some View {
        VStack(spacing: 10) {
            Button {
                Task {
                    try await authVM.signIn(
                        withEmail: loginVM.email,
                        password: loginVM.password
                    )
                }
            } label: {
                Text("Войти")
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
            }
            .alert(authVM.alertMessage, isPresented: $authVM.showAlert, actions: {} )
            .disabled(!loginVM.formIsValid)
            .opacity(loginVM.formIsValid ? 1.0 : 0.5)

            Button("Забыли пароль?") {
                showResetAlert = true
                resetEmail = ""
            }
            .padding()
            .font(.callout)
            .foregroundColor(.blue)
        }
        .alert("Восстановление пароля", isPresented: $showResetAlert) {
            TextField("Введите почту", text: $resetEmail)
            Button("Отправить") {
                Task {
                    do {
                        try await authVM.sendPasswordReset(email: resetEmail)
                        resetMessage = "Письмо отправлено"
                    } catch {
                        resetMessage = "Ошибка: \(error.localizedDescription)"
                    }
                    showResetMessage = true
                }
            }
            Button("Отмена", role: .cancel) {}
        }
        .alert(resetMessage, isPresented: $showResetMessage) {}
    }
}
