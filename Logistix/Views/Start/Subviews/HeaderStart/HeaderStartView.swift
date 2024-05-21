//
//  HeaderStartView.swift
//  Logistix
//
//  Created by Serge Broski on 5/21/24.
//

import SwiftUI

struct HeaderStartView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            LoginStartButtonView()
            RegistrationStartButtonView()
        }
        .padding(.trailing, 50)
        .padding(.top, 200)
        .background {
            StartImageView()
        }
        .padding(.leading, 8)
    }
}

#Preview {
    HeaderStartView()
}
