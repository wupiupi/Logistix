//
//  TermsButtonView.swift
//  Logistix
//
//  Created by Serge Broski on 5/21/24.
//

import SwiftUI

struct TermsButtonView: View {
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
            print("DEBUG: \(title)")
        } label: {
            Text(title)
        }
        .fontWeight(.bold)
        .hAlign(.leading)
    }
}

#Preview {
    TermsButtonView(
        title: "Документы",
        action: {}
    )
}
