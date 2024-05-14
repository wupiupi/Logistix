//
//  RegistrationView.swift
//  Logistix
//
//  Created by Paul Makey on 14.05.24.
//

import SwiftUI

struct RegistrationView: View {
    @State private var email = ""
    @State private var fullName = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    
    @StateObject var authManager = AuthenticationManager()
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Впервые у нас?\nЗарегистрируйся!")
                .multilineTextAlignment(.center)
                .font(.largeTitle)
                .fontWeight(.bold)
            
            InputView(
                text: $email,
                title: "Почта",
                placeholder: "Example@gmail.com"
            )
            .textInputAutocapitalization(.never)
            
            InputView(
                text: $fullName,
                title: "Имя",
                placeholder: "Иванов Иван Иванович"
            )
            
            InputView(
                text: $password,
                title: "Пароль",
                placeholder: "Пароль",
                isSecureField: true
            )
            
            ZStack {
                InputView(
                    text: $confirmPassword,
                    title: "Подтвердить пароль",
                    placeholder: "Подтвердите пароль",
                    isSecureField: true
                )
                
                if !password.isEmpty && !confirmPassword.isEmpty {
                    if password == confirmPassword {
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
            
            Button {
                authManager.signUp()
            } label: {
                Text("Зарегистрироваться")
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
                    .disabled(!formIsValid)
                    .opacity(formIsValid ? 1.0 : 0.5)
            }
        }
    }
}

// MARK: - AuthenticationFormProtocol
extension RegistrationView: AuthenticationFormProtocol {
    var formIsValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 5
        && confirmPassword == password
        && !fullName.isEmpty
    }
}

#Preview {
    RegistrationView()
}
