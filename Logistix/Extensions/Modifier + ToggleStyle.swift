//
//  Modifier + ToggleStyle.swift
//  Logistix
//
//  Created by Serge Broski on 5/22/24.
//

import SwiftUI

// MARK: - CheckboxToggleStyle
struct CheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            RoundedRectangle(cornerRadius: 5.0)
                .stroke(lineWidth: 2)
                .frame(width: 25, height: 25)
                .cornerRadius(5.0)
                .overlay {
                    if configuration.isOn {
                        Image(systemName: "rectangle.fill")
                    }
                }
                .onTapGesture {
                    withAnimation(.spring()) {
                        configuration.isOn.toggle()
                    }
                }
            
            configuration.label
            
        }
    }
}
