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
                    text: $registrationVM.autoBrand,
                    title: "Марка авто",
                    placeholder: "BMW, Mercedes"
                )
                
                InputView(
                    text: $registrationVM.autoMaxWeight,
                    title: "Максимально допустимый вес",
                    placeholder: "xxx кг"
                )
                
                InputView(
                    text: $registrationVM.autoRegNumber,
                    title: "Регистрационный номер",
                    placeholder: "1111XX-X"
                )
                
                RegistrationFieldsView()
                
                RegistrationButtonView()
            }
        }
        .scrollIndicators(.hidden)
    }
}
