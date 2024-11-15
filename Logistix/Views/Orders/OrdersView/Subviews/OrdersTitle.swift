//
//  OrdersTitle.swift
//  Logistix
//
//  Created by Serge Broski on 5/22/24.
//

import SwiftUI

struct OrdersTitle: View {
    var title: String? = nil
    
    var body: some View {
        Text(title ?? "Текущие заказы")
            .modifier(
                TitleModifier(
                    font: .largeTitle,
                    fontWeight: .semibold,
                    color: Color(hex: 0x363746, alpha: 1)
                )
            )
    }
}
