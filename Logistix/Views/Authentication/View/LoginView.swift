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
    @StateObject var authManager = AuthenticationManager()
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 30) {
                Text("Привет, 👋🏻")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                InputView(
                    text: $authManager.email,
                    title: "Почта",
                    placeholder: "Example@gmail.com"
                )
                .textInputAutocapitalization(.never)
                
                InputView(
                    text: $authManager.pass,
                    title: "Пароль",
                    placeholder: "Пароль",
                    isSecureField: true
                )
                .padding(.bottom, 20)
                
                
                #warning("wtf")
                if authManager.isLoading {
                    ProgressView()
                }
                
                #warning("wtf")
                if let error = authManager.errorMessage {
                    Text(error)
                        .foregroundStyle(.pink)
                }

                
                Button {
                    authManager.login()
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
//                .disabled(!formIsValid)
                .opacity(formIsValid ? 1.0 : 0.5)
                
                // Sign up Button
                NavigationLink {
                    RegistrationView()
                        .navigationBarBackButtonHidden()
                } label: {
                    HStack(spacing: 2) {
                        Text("Еще не зарегистрированы?")
                        Text("Регистрация")
                            .fontWeight(.bold)
                    }
                    .foregroundStyle(.main)
                }
                
                Button("Log in anon") {
                    authManager.anonymouslyLogin()
                }
                .disabled(authManager.isLoading)
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
