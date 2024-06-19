//
//  TermsView.swift
//  Logistix
//
//  Created by Serge Broski on 5/21/24.
//

import SwiftUI

struct TermsView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 15)  {
            TermsLinkView(
                title: "Документы",
                stringURL: "https://developer.apple.com/documentation/technologies"
            )
            
            TermsLinkView(
                title: "Политика конфиденциальности",
                stringURL: "https://www.apple.com/legal/privacy/en-ww/"
            )
            
            TermsLinkView(
                title: "Пользовательское соглашение",
                stringURL: "https://www.apple.com/legal/internet-services/itunes/dev/stdeula/"
            )
        }
        .padding(.bottom, 40)
    }
}

#Preview {
    TermsView()
}
