//
//  LoginButtonView.swift
//  Logistix
//
//  Created by Serge Broski on 5/21/24.
//

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
                    Capsule()
                        .frame(
                            width: UIScreen.main.bounds.width - 64,
                            height: 50
                        )
                        .foregroundStyle(Color.main)
                }
        }
        .alert(authVM.alertMessage, isPresented: $authVM.showAlert, actions: {} )
        .disabled(!loginVM.formIsValid)
        .opacity(loginVM.formIsValid ? 1.0 : 0.5)
    }
}

#Preview {
    LoginButtonView()
        .environmentObject(AuthViewModel())
        .environmentObject(LoginViewModel())
}
