//
//  LoginFieldsView.swift
//  Logistix
//
//  Created by Serge Broski on 5/21/24.
//

import SwiftUI

struct LoginFieldsView: View {
    @EnvironmentObject private var loginVM: LoginViewModel
    
    var body: some View {
        InputView(
            text: $loginVM.email,
            title: "Почта",
            placeholder: "Example@gmail.com"
        )
        .textInputAutocapitalization(.never)
        
        InputView(
            text: $loginVM.password,
            title: "Пароль",
            placeholder: "Пароль",
            isSecureField: true
        )
        .padding(.bottom, 20)
        .onAppear {
            // Clearing fields so that the next time this view appears, the entered data will not remain
            loginVM.email = ""
            loginVM.password = ""
        }
    }
}

#Preview {
    LoginFieldsView()
        .environmentObject(LoginViewModel())
}
