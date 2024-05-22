//
//  PaymentMethodNewOrderView.swift
//  Logistix
//
//  Created by Serge Broski on 5/22/24.
//

import SwiftUI

struct PaymentMethodNewOrderView: View {
    @EnvironmentObject private var newOrderVM: NewOrderViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Способ оплаты")
                .font(.title)
                .fontWeight(.bold)
                .foregroundStyle(Color(hex: 0x363746, alpha: 1))
                .padding(.leading)
            
            Text("Выберите способ оплаты:")
                .foregroundStyle(Color(hex: 0x363746, alpha: 1))
                .font(.title3)
                .padding(.leading)
            
            Picker("", selection: $newOrderVM.payment) {
                ForEach(NewOrderViewModel.Payment.allCases, id: \.self) {
                    Text($0.rawValue)
                }
            }
            .pickerStyle(.segmented)
        }
        .padding(.bottom, 20)
    }
}

#Preview {
    PaymentMethodNewOrderView()
        .environmentObject(NewOrderViewModel(selectedWeight: .belowOneHundred))
}
