//
//  CarrierView.swift
//  Logistix
//
//  Created by Serge Broski on 5/21/24.
//

import SwiftUI

struct CarrierView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Для перевозчиков")
                .foregroundStyle(.white)
                .font(.largeTitle)
                .fontWeight(.bold)
            
            CarrierInfoView(
                text: "Все грузовладельцы на одной платформе – получайте выгодные заказы"
            )
            
            CarrierInfoView(
                text: "Только выгодные рейсы – наши перевозчики зарабатывают более 200 000 рублей в год с каждой машины"
            )
            
            CarrierInfoView(
                text: "Гарантия загрузки – более 70 000 рейсов"
            )
            
            CarrierButtonView()
        }
        .padding([.leading, .trailing], 8)
        .padding(.vertical, 35)
        .background {
            Rectangle()
                .fill(Color(hex: 0x252B42, alpha: 1))
        }
        .padding(.bottom, -10)
    }
}

#Preview {
    CarrierView()
}
