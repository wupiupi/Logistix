//
//  SocialsView.swift
//  Logistix
//
//  Created by Serge Broski on 5/21/24.
//

import SwiftUI

struct SocialsView: View {
    var body: some View {
        HStack(spacing: 25) {
            SocialButtonView(
                image: "facebook.icon",
                action: {}
            )
            
            SocialButtonView(
                image: "instagram.icon",
                action: {}
            )
            
            SocialButtonView(
                image: "twitter.icon",
                action: {}
            )
        }
    }
}

#Preview {
    SocialsView()
}
