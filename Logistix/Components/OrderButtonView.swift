//
//  OrderButtonView.swift
//  Logistix
//
//  Created by Serge Broski on 5/22/24.
//

import SwiftUI

struct OrderButtonView: View {    
    let title: String
    let titleColor: Color
    let backColor: Color
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(title)
                .font(.title2)
                .foregroundStyle(titleColor)
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(backColor)
                }
        }
    }
}

#Preview {
    OrderButtonView(
        title: "Отменить",
        titleColor: .white,
        backColor: .main,
        action: {}
    )
}
