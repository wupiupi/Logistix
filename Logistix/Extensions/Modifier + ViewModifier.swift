//
//  Modifier + ViewModifier.swift
//  Logistix
//
//  Created by Serge Broski on 5/22/24.
//

import SwiftUI

struct TitleModifier: ViewModifier {
    let font: Font
    let fontWeight: Font.Weight
    
    func body(content: Content) -> some View {
        content
            .foregroundStyle(Color(hex: 0x363746, alpha: 1))
            .font(font)
            .fontWeight(fontWeight)
    }
}
