//
//  CarrierNewOrderView.swift
//  Logistix
//
//  Created by Serge Broski on 5/22/24.
//

import SwiftUI

struct CarrierNewOrderView: View {
    @EnvironmentObject private var newOrderVM: NewOrderViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            VStack {
                Text("Что везём")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(Color(hex: 0x363746, alpha: 1))
                    .padding(.leading)
                
                Text("Тип вложения")
                    .foregroundStyle(Color(hex: 0x363746, alpha: 1))
                    .font(.title3)
            }
            
            Picker("Тип вложения", selection: $newOrderVM.cargoType) {
                ForEach(NewOrderViewModel.CargoType.allCases, id: \.self) {
                    Text($0.rawValue)
                }
            }
            .tint(.white)
            .frame(
                width: UIScreen.main.bounds.width - 32,
                height: 40
            )
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color(hex: 0x00CCA6, alpha: 1))
            }
            .hAlign(.center)
            
            Text("Вес:")
                .foregroundStyle(Color(hex: 0x363746, alpha: 1))
                .font(.title3)
                .padding(.leading)
            
            Picker("", selection: $newOrderVM.selectedWeight) {
                ForEach(NewOrderViewModel.Weight.allCases, id: \.self) {
                    Text($0.rawValue)
                }
            }
            .pickerStyle(.segmented)
        }
        .padding(.bottom, 20)
    }
}

#Preview {
    CarrierNewOrderView()
        .environmentObject(NewOrderViewModel(selectedWeight: .belowOneHundred))
}
