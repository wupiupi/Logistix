import SwiftUI

struct LoginButtonView: View {
    @EnvironmentObject private var authVM: AuthViewModel
    @EnvironmentObject private var loginVM: LoginViewModel
        
    var body: some View {
        Button {
            Task {
                try await authVM.signIn(
                    withEmail: loginVM.email,
                    password: loginVM.hashedPassword
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
    }
}
