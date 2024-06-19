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
            SocialLinkView(
                image: "facebook.icon",
                stringURL: "https://www.facebook.com/apple/"
            )
            
            SocialLinkView(
                image: "instagram.icon",
                stringURL: "https://www.instagram.com/apple/"
            )
            
            SocialLinkView(
                image: "twitter.icon",
                stringURL: "https://x.com/x/migrate"
            )
        }
    }
}

#Preview {
    SocialsView()
}
