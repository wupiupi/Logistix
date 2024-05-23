//
//  WorthNewOrderView.swift
//  Logistix
//
//  Created by Serge Broski on 5/22/24.
//

import SwiftUI

struct WorthNewOrderView: View {
    @EnvironmentObject private var newOrderVM: NewOrderViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Ценность груза")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(Color(hex: 0x363746, alpha: 1))
                
                Text("BYN")
                    .font(.footnote)
                    .fontWeight(.semibold)
                    .foregroundStyle(.backgroundGray)
            }
            
            InputView(
                text: $newOrderVM.cargoCost,
                title: "",
                placeholder: "Ценность груза",
                isNumPad: true
            )
            
            Text("Компенсируем ценность поврежденного груза в течении трех рабочих дней. Максимальная компенсация – 3000 BYN")
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .foregroundStyle(.backgroundGray)
        }
        .hAlign(.center)
        .padding(.bottom, 20)
    }
}

#Preview {
    WorthNewOrderView()
        .environmentObject(NewOrderViewModel(selectedWeight: .belowOneHundred))
}
