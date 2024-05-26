//
//  CreateNewOrderButtonView.swift
//  Logistix
//
//  Created by Serge Broski on 5/22/24.
//

import SwiftUI
import RealmSwift

struct CreateNewOrderButtonView: View {
    @ObservedResults(Order.self) private var orders
    @EnvironmentObject private var newOrderVM: NewOrderViewModel
    @EnvironmentObject private var authVM: AuthViewModel
    
    var body: some View {
        Button {
            if newOrderVM.formIsValid {
                createOrder()
                newOrderVM.alertTitle = "Готово"
                newOrderVM.alertMessage = "Ваша заявка успешно зарегистрирована!"
            }
            newOrderVM.showAlert = true
        } label: {
            HStack {
                Text("Отправить заявку")
                    .font(.title2)
                    .foregroundStyle(.white)
                    .fontWeight(.semibold)
            }
            .padding(.top, 10)
            .padding(.bottom, 5)
            .padding([.leading, .trailing], 16)
            .foregroundStyle(.white)
        }
        .background {
            Capsule()
                .fill(Color(hex: 0x00CCA6, alpha: 1))
        }
        .hAlign(.center)
        .disabled(!newOrderVM.isAgreededPrivacy)
        .opacity(newOrderVM.isAgreededPrivacy ? 1 : 0.3)
        .alert(
            newOrderVM.alertTitle,
            isPresented: $newOrderVM.showAlert,
            actions: {
                Button("OK") {
                   clearFields()
                }
            },
            message: {
                Text(newOrderVM.alertMessage)
            }
        )
    }
    
    private func createOrder() {
        let order = Order()
        let route = Route()
        let sender = Sender()
        let recipient = Recipient()
        let price = Price()
        
        order.userID = authVM.currentUser?.id ?? ""
        order.trackingNumber = .generateTrackNum()
        
        /// - Route Implementation
        route.sourceAddress = newOrderVM.sourceAddress
        route.destinationAddress = newOrderVM.destinationAddress
        order.route = route
        
        /// - Sender Implementation
        sender.name = newOrderVM.senderName
        sender.phoneNumber = newOrderVM.senderPhoneNumber
        order.sender = sender
        
        /// - Recipient Implementation
        recipient.name = newOrderVM.recipientName
        recipient.phoneNumber = newOrderVM.recipientPhoneNumber
        order.recipient = recipient
        
        order.cargoType = newOrderVM.cargoType.rawValue
        order.weight = newOrderVM.selectedWeight.rawValue
        order.dateOfLoading = newOrderVM.dateOfLoading ?? Date()
        order.dateOfDelivery = newOrderVM.dateOfDelivery ?? Date()
        
        price.payment = newOrderVM.payment.rawValue
        price.cargoCost = newOrderVM.cargoCost
        price.totalCost = newOrderVM.totalCost
        order.price = price
        
        $orders.append(order)
    }
    
    private func clearFields() {
        newOrderVM.sourceAddress = ""
        newOrderVM.destinationAddress = ""
        newOrderVM.senderName = ""
        newOrderVM.senderPhoneNumber = ""
        newOrderVM.recipientName = ""
        newOrderVM.recipientPhoneNumber = ""
        newOrderVM.cargoCost = ""
        newOrderVM.isAgreededPrivacy = false
    }
}
