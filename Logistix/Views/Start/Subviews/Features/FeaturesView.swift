//
//  FeaturesView.swift
//  Logistix
//
//  Created by Serge Broski on 5/21/24.
//

import SwiftUI

struct FeaturesView: View {
    var body: some View {
        FeatureView(
            imageName: "handshake",
            text: "Более 6 000 перевозчиков работают с нами"
        )
        
        FeatureView(
            imageName: "truck",
            text: "Свыше 100 000 рейсов в год"
        )
        
        FeatureView(
            imageName: "insurance",
            text: "Своя служба безопасности",
            textColor: .white,
            backgroundColor: .main
        )
    }
}

#Preview {
    FeaturesView()
}
