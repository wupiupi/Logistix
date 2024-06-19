//
//  StartImageView.swift
//  Logistix
//
//  Created by Serge Broski on 5/21/24.
//

import SwiftUI

struct StartImageView: View {
    var body: some View {
        Image("trucks")
            .resizable()
            .scaledToFill()
            .frame(
                width: UIScreen.main.bounds.midX,
                height: UIScreen.main.bounds.height / 1.7
            )
            .padding(.bottom, 175)
    }
}

#Preview {
    StartImageView()
}
