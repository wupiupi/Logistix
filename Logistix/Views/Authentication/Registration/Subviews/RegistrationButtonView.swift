//
//  RegistrationButtonView.swift
//  Logistix
//
//  Created by Serge Broski on 5/21/24.
//

import SwiftUI

struct RegistrationButtonView: View {
    @EnvironmentObject private var authVM: AuthViewModel
    @EnvironmentObject private var registrationVM: RegistrationViewModel
    
    var body: some View {
        Button {
            Task {
                try await authVM.createUser(
                    withEmail: registrationVM.email,
                    password: registrationVM.password,
                    fullName: registrationVM.fullName,
                    phoneNumber: nil,
                    role: registrationVM.auto.isEmpty ? .user : .driver,
                    auto: registrationVM.auto
                )
            }
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
                .disabled(!registrationVM.formIsValid)
                .opacity(registrationVM.formIsValid ? 1.0 : 0.5)
        }
        .alert(authVM.alertMessage, isPresented: $authVM.isEmailTaken, actions: {} )
    }
}

#Preview {
    RegistrationButtonView()
        .environmentObject(AuthViewModel())
        .environmentObject(RegistrationViewModel())
}
