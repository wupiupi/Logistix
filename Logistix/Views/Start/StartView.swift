//
//  StartView.swift
//  Logistix
//
//  Created by Paul Makey on 11.05.24.
//

import SwiftUI

struct StartView: View {
    var body: some View {
        NavigationStack {
                ScrollView {
                    HeaderStartView()
                    
                    FeaturesView()
                    
                    ProductsView()
                    
                    CarrierView()
                    
                    FooterStartView()
                }
                .scrollIndicators(.hidden)
                .background(.backStart)
                .navigationTitle("Logistix")
        }
    }
}

#Preview {
    StartView()
}
