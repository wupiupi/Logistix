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
            TermsButtonView(
                title: "Документы",
                action: {}
            )
            
            TermsButtonView(
                title: "Политика конфиденциальности",
                action: {}
            )
            
            TermsButtonView(
                title: "Пользовательское соглашение",
                action: {}
            )
        }
        .padding(.bottom, 40)
    }
}

#Preview {
    TermsView()
}
