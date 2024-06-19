//
//  FooterStartView.swift
//  Logistix
//
//  Created by Serge Broski on 5/21/24.
//

import SwiftUI

struct FooterStartView: View {
    var body: some View {
        VStack(alignment: .leading) {
            TermsView()
            
            ContactsView()
        }
        .padding(.leading, 8)
        .padding(.vertical, 35)
        .background {
            Rectangle()
                .fill(.white)
        }
        .foregroundStyle(.black)
        .padding(.bottom, -33)
    }
}

#Preview {
    FooterStartView()
}
