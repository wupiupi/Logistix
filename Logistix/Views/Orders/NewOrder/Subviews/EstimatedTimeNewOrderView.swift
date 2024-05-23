//
//  EstimatedTimeNewOrderView.swift
//  Logistix
//
//  Created by Serge Broski on 5/22/24.
//

import SwiftUI

struct EstimatedTimeNewOrderView: View {
    @EnvironmentObject private var newOrderVM: NewOrderViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Расчетное время")
                .font(.title)
                .fontWeight(.bold)
                .foregroundStyle(Color(hex: 0x363746, alpha: 1))
            
            Text("Дата погрузки")
                .foregroundStyle(Color(hex: 0x363746, alpha: 1))
                .font(.title3)
            
            CustomDatePickerView(date: $newOrderVM.dateOfLoading)
            
            Text("Дата доставки")
                .foregroundStyle(Color(hex: 0x363746, alpha: 1))
                .font(.title3)
            
            CustomDatePickerView(date: $newOrderVM.dateOfDelivery)
        }
        .padding(.leading)
    }
}

#Preview {
    EstimatedTimeNewOrderView()
        .environmentObject(NewOrderViewModel(selectedWeight: .belowOneHundred))
}
