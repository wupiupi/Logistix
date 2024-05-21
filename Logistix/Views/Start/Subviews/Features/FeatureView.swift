//
//  FeatureView.swift
//  Logistix
//
//  Created by Serge Broski on 5/21/24.
//

import SwiftUI

struct FeatureView: View {
    let imageName: String
    let text: String
    let textColor: Color
    let backgroundColor: Color
    
    init(
        imageName: String,
        text: String,
        textColor: Color = .black,
        backgroundColor: Color = .white
    ) {
        self.imageName = imageName
        self.text = text
        self.textColor = textColor
        self.backgroundColor = backgroundColor
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Image(imageName)
                .resizable()
                .frame(width: 66, height: 66)
            
            Text(text)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(textColor)
        }
        .padding(.vertical, 30)
        .background {
            Rectangle()
                .fill(backgroundColor)
                .frame(width: UIScreen.main.bounds.width)
        }
    }
}

#Preview {
    FeatureView(
        imageName: "handshake",
        text: "Более 6 000 перевозчиков работают с нами"
    )
}
