//
//  InTotalNewOrderView.swift
//  Logistix
//
//  Created by Serge Broski on 5/22/24.
//

import SwiftUI

struct InTotalNewOrderView: View {
    @EnvironmentObject private var newOrderVM: NewOrderViewModel
    
    var body: some View {
        VStack(alignment: .center) {
            Text("Итого:")
                .font(.title3)
                .foregroundStyle(Color(hex: 0x363746, alpha: 1))
            
            
            Text("\(newOrderVM.totalCost) BYN")
                .font(.title)
                .fontWeight(.bold)
        }
        .frame(width: UIScreen.main.bounds.width - 42)
        .padding(.vertical, 40)
        .background {
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(.white)
                .shadow(radius: 10)
        }
        .hAlign(.center)
        
        VStack {
            Toggle(isOn: $newOrderVM.isAgreededPrivacy) {
                VStack {
                    Text("Согласен(-на) на обработку")
                        .font(.subheadline)
                        .foregroundStyle(.backgroundGray)
                    Text("персональных данных согласно")
                        .font(.subheadline)
                        .foregroundStyle(.backgroundGray)
                    Button {
                        
                    } label: {
                        Text("политике конфиденциальности")
                            .font(.subheadline)
                            .foregroundStyle(.black)
                    }
                }
            }
            .toggleStyle(CheckboxToggleStyle())
        }
        .hAlign(.center)
        .padding(.bottom, 20)
    }
}

#Preview {
    InTotalNewOrderView()
        .environmentObject(NewOrderViewModel(selectedWeight: .belowOneHundred))
}
