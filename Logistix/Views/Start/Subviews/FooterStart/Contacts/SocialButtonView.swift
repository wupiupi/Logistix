//
//  SocialButtonView.swift
//  Logistix
//
//  Created by Serge Broski on 5/21/24.
//

import SwiftUI

struct SocialButtonView: View {
    let image: String
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
            print("DEBUG: \(image)")
        } label: {
            Image(image)
                .resizable()
                .frame(width: 23, height: 23)
        }
    }
}

#Preview {
    SocialButtonView(
        image: "facebook.icon",
        action: {}
    )
}
