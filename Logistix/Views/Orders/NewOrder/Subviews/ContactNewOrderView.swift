//
//  ContactNewOrderView.swift
//  Logistix
//
//  Created by Serge Broski on 5/22/24.
//

import SwiftUI

struct ContactNewOrderView: View {
    @EnvironmentObject private var newOrderVM: NewOrderViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Контактные данные")
                .font(.title)
                .fontWeight(.bold)
                .foregroundStyle(Color(hex: 0x363746, alpha: 1))
                .padding(.leading)
            
            #warning("TODO: - Insert Name of Current User as Placeholder")
            
            VStack {
                InputView(
                    text: $newOrderVM.senderName,
                    title: "Отправитель:",
                    placeholder: "Иванов Иван Иванович"
                )
                
                InputView(
                    text: $newOrderVM.senderPhoneNumber,
                    title: "Телефон:",
                    placeholder: "+375(XX)XXX-XX-XX"
                )
                
                InputView(
                    text: $newOrderVM.recipientName,
                    title: "Получатель:",
                    placeholder: "Иванов Иван Иванович"
                )
                
                InputView(
                    text: $newOrderVM.recipientPhoneNumber,
                    title: "Телефон:",
                    placeholder: "+375(XX)XXX-XX-XX"
                )
            }
            .hAlign(.center)
        }
        .padding(.bottom, 20)
    }
}

#Preview {
    ContactNewOrderView()
        .environmentObject(NewOrderViewModel(selectedWeight: .belowOneHundred))
}
