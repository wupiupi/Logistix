//
//  CustomDatePickerView.swift
//  Logistix
//
//  Created by Serge Broski on 5/22/24.
//

import SwiftUI

struct CustomDatePickerView: View {
    @Binding var date: Date?
    
    var body: some View {
        DatePickerTextFieldView(
            placeholder: "Выберите дату",
            date: $date
        )
        .font(.title)
        .padding(.horizontal, 16)
        .frame(width: UIScreen.main.bounds.width - 32, height: 46)
        .background {
            RoundedRectangle(cornerRadius: 10)
                .fill(.white)
                .background {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke()
                        .foregroundStyle(Color.main)
                }
        }
    }
}

#Preview {
    CustomDatePickerView(date: .constant(Date.now))
}
