//
//  CarrierInfoView.swift
//  Logistix
//
//  Created by Serge Broski on 5/21/24.
//

import SwiftUI

struct CarrierInfoView: View {
    let text: String
    
    var body: some View {
        HStack {
            Image(systemName: "checkmark.circle.fill")
                .resizable()
                .foregroundStyle(.green)
                .frame(width: 32, height: 32)
            
            Text(text)
                .font(.callout)
                .foregroundStyle(.white)
        }
    }
}

#Preview {
    CarrierInfoView(text: "Все грузовладельцы на одной платформе – получайте выгодные заказы")
}
