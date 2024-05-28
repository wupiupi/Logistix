//
//  ApplicationInfoView.swift
//  Logistix
//
//  Created by Serge Broski on 5/22/24.
//

import SwiftUI
import RealmSwift

struct ApplicationInfoView: View {
    @ObservedResults(ApplicationForm.self) var applications
    @EnvironmentObject private var applicationsVM: ApplicationsViewModel
    
    let application: ApplicationForm
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            Text("№ \(application.id)")
                .modifier(TitleModifier(font: .title, fontWeight: .bold))
            
            OrderDetailsView(
                title: "Имя контакта",
                orderInfo: application.name
            )
            OrderDetailsView(
                title: "Электронная почта",
                orderInfo: application.email
            )
            OrderDetailsView(
                title: "Компания",
                orderInfo: application.company
            )
            OrderDetailsView(
                title: "Контактный телефон",
                orderInfo: application.phone
            )
            
            Text("Статус")
                .font(.title3)
                .foregroundStyle(.gray)
            
            Text(application.status)
                .font(.title3)
                .foregroundStyle(
                    Color(
                        hex: 0x00CCA6,
                        alpha: 1
                    )
                )
                .padding([.top, .bottom], 8)
                .padding([.leading, .trailing], 8)
                .background {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.main.opacity(0.2))
                }
            
            OrderButtonView(
                title: "Подтвердить ответ",
                titleColor: .white,
                backColor: .green) {
                    applicationsVM.storageManager.write {
                        application.thaw()?.status = "Отвечено"
                    }
                }
            
            OrderButtonView(
                title: "Удалить",
                titleColor: .red,
                backColor: .clear) {
                    $applications.remove(application)
                }
        }
        .padding()
        .hAlign(.center)    }
}

#Preview {
    ApplicationInfoView(application: ApplicationForm())
        .environmentObject(ApplicationForm())
}
