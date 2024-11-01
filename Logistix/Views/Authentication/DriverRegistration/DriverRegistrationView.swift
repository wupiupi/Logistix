//
//  DriverRegistrationView.swift
//  Logistix
//
//  Created by Serge Broski on 9/18/24.
//

import SwiftUI

struct DriverRegistrationView: View {
    @EnvironmentObject private var registrationVM: RegistrationViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Водитель?\nРады видеть!")
                .multilineTextAlignment(.center)
                .font(.title3)
                .fontWeight(.bold)
            
            InputView(
                text: $registrationVM.auto,
                title: "Авто",
                placeholder: "Номер и модель авто"
            )
            
            RegistrationFieldsView()
            
            RegistrationButtonView()
        }
    }
}

#Preview {
    DriverRegistrationView()
        .environmentObject(AuthViewModel())
        .environmentObject(RegistrationViewModel())
}
