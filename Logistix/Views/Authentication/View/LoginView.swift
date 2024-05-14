//
//  LoginView.swift
//  Logistix
//
//  Created by Paul Makey on 14.05.24.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 30) {
                Text("Привет, 👋🏻")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                InputView(
                    text: $email,
                    title: "Почта",
                    placeholder: "Example@gmail.com"
                )
                .textInputAutocapitalization(.never)
                
                InputView(
                    text: $password,
                    title: "Пароль",
                    placeholder: "Пароль",
                    isSecureField: true
                )
                .padding(.bottom, 20)
                
                Button {
                    
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
                .disabled(!formIsValid)
                .opacity(formIsValid ? 1.0 : 0.5)
            }
            
        }
    }
}

extension LoginView: AuthenticationFormProtocol {
    var formIsValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 5
    }
}

#Preview {
    LoginView()
}
