//
//  RegistrationView.swift
//  Logistix
//
//  Created by Paul Makey on 14.05.24.
//

import SwiftUI

struct RegistrationView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Впервые у нас?\nЗарегистрируйся!")
                .multilineTextAlignment(.center)
                .font(.largeTitle)
                .fontWeight(.bold)
            
            RegistrationFieldsView()

            RegistrationButtonView()
            
            NavigationLink {
                DriverRegistrationView()
            } label: {
                Text("Отдельная регистрация для водителей")
            }
        }
    }
}

#Preview {
    RegistrationView()
        .environmentObject(AuthViewModel())
        .environmentObject(RegistrationViewModel())
}
