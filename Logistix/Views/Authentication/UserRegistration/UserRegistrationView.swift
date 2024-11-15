//
//  UserRegistrationView.swift
//  Logistix
//
//  Created by Paul Makey on 1.11.24.
//

import SwiftUI

struct UserRegistrationView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Есть товар, но некому доставить?")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundStyle(.statusGreen)
            
            Text("Регистрируйтесь и размещайте\nВаши предложения!")
                .multilineTextAlignment(.center)
                .font(.title3)
                .fontWeight(.bold)
            
            RegistrationFieldsView()
            
            RegistrationButtonView()
            
            Spacer()
        }
    }
}
