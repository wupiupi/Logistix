//
//  CreateNewOrderButtonView.swift
//  Logistix
//
//  Created by Serge Broski on 5/22/24.
//

import SwiftUI

struct CreateNewOrderButtonView: View {
    @EnvironmentObject private var newOrderVM: NewOrderViewModel
    @EnvironmentObject private var authVM: AuthViewModel
    @EnvironmentObject private var ordersVM: OrdersViewModel
        
    var body: some View {
        Button {
            if newOrderVM.formIsValid {
                Task {
                    newOrderVM.alertTitle = "Готово"
                    newOrderVM.alertMessage = "Ваш заказ отправлен на модерацию.\n" + #"Вы можете просмотреть его в разделе "Заказы""#
                    await createOrder()
                }
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
    
    private func createOrder() async {
        let order = Order(
            id: String.generateTrackNum(),
            userID: authVM.currentUser?.id ?? "",
            assignedDriverID: "",
            status: OrderStatus.onModeration.rawValue,
            sourceAddress: newOrderVM.sourceAddress,
            destinationAddress: newOrderVM.destinationAddress,
            senderName: newOrderVM.senderName,
            senderPhoneNumber: newOrderVM.senderPhoneNumber,
            recipientName: newOrderVM.recipientName,
            recipientPhoneNumber: newOrderVM.recipientPhoneNumber,
            cargoType: newOrderVM.cargoType.rawValue,
            weight: newOrderVM.selectedWeight.rawValue,
            dateOfLoading: newOrderVM.dateOfLoading ?? Date(),
            dateOfDelivery: newOrderVM.dateOfDelivery ?? Date(),
            cargoCost: newOrderVM.cargoCost,
            paymentType: newOrderVM.payment.rawValue,
            totalCost: newOrderVM.totalCost
        )
        await authVM.addOrderToUser(order: order)
        ordersVM.updateOrders()
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
