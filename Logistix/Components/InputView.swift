//
//  InputView.swift
//  Logistix
//
//  Created by Paul Makey on 12.05.24.
//

import SwiftUI

struct InputView: View {
    @Binding var text: String
    let title: String
    let placeholder: String
    var isSecureField: Bool = false
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(title)
                .foregroundStyle(.black)
                .font(.title3)
            
            TextField(placeholder, text: $text)
                .foregroundStyle(.white)
                .frame(
                    width: UIScreen.main.bounds.width - 82,
                    height: 50
                )
                .padding(.leading, 16)
                .background {
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundStyle(
                            Color(
                                hex: 0xF9F9F9,
                                alpha: 1
                            )
                        )
                        .background {
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(
                                    Color(
                                        hex: 0xDDDDDD,
                                        alpha: 1
                                    ),
                                    lineWidth: 3
                                )
                        }
                }
        }
    }
}

#Preview {
    InputView(
        text: .constant(""),
        title: "Имя *",
        placeholder: "Полное имя*"
    )
}
