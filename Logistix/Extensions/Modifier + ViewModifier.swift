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
    let color: Color
    
    func body(content: Content) -> some View {
        content
            .foregroundStyle(color)
            .font(font)
            .fontWeight(fontWeight)
    }
}
