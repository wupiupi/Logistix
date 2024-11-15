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
        ScrollView {
            VStack(spacing: 20) {
                Text("Форма регистрации для водителей")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundStyle(.statusGreen)
                
                Text("Регистрируйтесь и смотрите,\nкакие заказы сейчас доступны!")
                    .multilineTextAlignment(.center)
                    .font(.title3)
                    .fontWeight(.bold)
                
                InputView(
                    text: $registrationVM.auto,
                    title: "Авто",
                    placeholder: "Номер и модель"
                )
                
                RegistrationFieldsView()
                
                RegistrationButtonView()
            }
        }
        .scrollIndicators(.hidden)
    }
}
