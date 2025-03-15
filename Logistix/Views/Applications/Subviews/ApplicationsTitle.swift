import SwiftUI

struct ApplicationsTitle: View {
    let title: String
    
    var body: some View {
        Text(title)
            .modifier(
                TitleModifier(
                    font: .title,
                    fontWeight: .semibold,
                    color: .text
                )
            )
            .multilineTextAlignment(.center)
    }
}
