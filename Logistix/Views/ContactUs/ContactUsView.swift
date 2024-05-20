//
//  ContactUsView.swift
//  Logistix
//
//  Created by Paul Makey on 12.05.24.
//

import SwiftUI
import RealmSwift

struct ContactUsView: View {
    @State private var name = ""
    @State private var email = ""
    @State private var company = ""
    @State private var phone = ""
    @State private var isShowingAlert = false
    
    @ObservedResults(ApplicationForm.self) var applications
    
    var body: some View {
        VStack {
            Text("Связаться с нами")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .padding(.bottom, 6)
            
            // Form Fields
            VStack(spacing: 20) {
                InputView(
                    text: $name,
                    title: "Имя *",
                    placeholder: "Полное Имя *"
                )
                InputView(
                    text: $email,
                    title: "Адрес электронной почты *",
                    placeholder: "example@gmail.com"
                )
                InputView(
                    text: $company,
                    title: "Комания *",
                    placeholder: #"ООО "Ромашка""#
                )
                InputView(
                    text: $phone,
                    title: "Телефон *",
                    placeholder: "+375(25)000-00-00"
                )
            }
            .padding(.bottom, 30)
            
            // TODO: - Button Logic Implementation
            Button {
                let application = ApplicationForm()
                application.name = name
                application.email = email
                application.company = company
                application.phone = phone
                application.date = Date.now
                
                $applications.append(application)
                
                isShowingAlert = true
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
                isPresented: $isShowingAlert,
                actions: {
                    Button("OK") {
                        name = ""
                        email = ""
                        company = ""
                        phone = ""
                    }
                },
                message: {
                    Text("Наши специалисты свяжутся с Вами в самое ближайшее время!")
                }
            )
        }
    }
}

#Preview {
    ContactUsView()
}
