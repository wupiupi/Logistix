//
//  ApplicationsTitle.swift
//  Logistix
//
//  Created by Serge Broski on 5/22/24.
//

import SwiftUI

struct ApplicationsTitle: View {
    var body: some View {
        Text("Заявки")
            .modifier(
                TitleModifier(
                    font: .largeTitle,
                    fontWeight: .semibold
                )
            )
    }
}

#Preview {
    ApplicationsTitle()
}
