//
//  ContactUsFieldsView.swift
//  Logistix
//
//  Created by Serge Broski on 5/21/24.
//

import SwiftUI

struct ContactUsFieldsView: View {
    @EnvironmentObject private var contactUsVM: ContactUsViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            InputView(
                text: $contactUsVM.name,
                title: "Имя *",
                placeholder: "Полное Имя *"
            )
            InputView(
                text: $contactUsVM.email,
                title: "Адрес электронной почты *",
                placeholder: "example@gmail.com"
            )
            InputView(
                text: $contactUsVM.company,
                title: "Компания *",
                placeholder: #"ООО "Ромашка""#
            )
            InputView(
                text: $contactUsVM.phone,
                title: "Телефон *",
                placeholder: "+375(25)000-00-00"
            )
        }
        .padding(.bottom, 30)
    }
}

#Preview {
    ContactUsFieldsView()
        .environmentObject(ContactUsViewModel())
}
