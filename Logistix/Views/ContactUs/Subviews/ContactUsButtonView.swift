//
//  ContactUsButtonView.swift
//  Logistix
//
//  Created by Serge Broski on 5/21/24.
//

import SwiftUI
import RealmSwift

struct ContactUsButtonView: View {
    @EnvironmentObject private var contactUsVM: ContactUsViewModel
    @ObservedResults(ApplicationForm.self) var applications
    
    var body: some View {
        Button {
            let application = ApplicationForm()
            application.name = contactUsVM.name
            application.email = contactUsVM.email
            application.company = contactUsVM.company
            application.phone = contactUsVM.phone
            application.date = Date.now
            
            $applications.append(application)
            
            contactUsVM.isShowingAlert = true
        } label: {
            Text("Отправить")
                .foregroundStyle(.white)
                .font(.title)
                .fontWeight(.semibold)
                .frame(
                    width: UIScreen.main.bounds.width - 70,
                    height: 50
                )
                .background {
                    Capsule()
                        .fill(Color(hex: 0x00CCA6, alpha: 1))
                }
        }
        .alert(
            "Готово",
            isPresented: $contactUsVM.isShowingAlert,
            actions: {
                Button("OK") {
                    contactUsVM.name = ""
                    contactUsVM.email = ""
                    contactUsVM.company = ""
                    contactUsVM.phone = ""
                }
            },
            message: {
                Text("Наши специалисты свяжутся с Вами в самое ближайшее время!")
            }
        )
        .disabled(!contactUsVM.formIsValid)
        .opacity(contactUsVM.formIsValid ? 1.0 : 0.5)
    }
}

#Preview {
    ContactUsButtonView()
        .environmentObject(ContactUsViewModel())
}
