//
//  RegistrationButtonView.swift
//  Logistix
//
//  Created by Serge Broski on 5/21/24.
//

import SwiftUI

struct RegistrationStartButtonView: View {
    var body: some View {
        NavigationLink {
            RegistrationView()
        } label: {
            CustomButtonView(
                title: "Регистрация",
                systemImage: "arrowshape.right.fill"
            )
        }
    }
}

#Preview {
    RegistrationStartButtonView()
}
