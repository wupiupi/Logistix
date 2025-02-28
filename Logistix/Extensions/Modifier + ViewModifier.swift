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
