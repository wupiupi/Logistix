//
//  BackgroundCardsView.swift
//  Logistix
//
//  Created by Serge Broski on 5/22/24.
//

import SwiftUI

struct BackgroundCardsView: View {
    @EnvironmentObject private var mainVM: MainViewModel
    
    var body: some View {
        ZStack {
            // Two Background Cards
            Color.white
                .opacity(0.5)
                .cornerRadius(mainVM.showMenu ? 15 : 0)
            // Shadow
                .shadow(
                    color: .black.opacity(0.07),
                    radius: 5,
                    x: -5,
                    y: 0
                )
                .offset(x: mainVM.showMenu ? -25 : 0)
                .padding(.vertical, 30)
            
            Color.white
                .opacity(0.4)
                .cornerRadius(mainVM.showMenu ? 15 : 0)
            // Shadow
                .shadow(
                    color: .black.opacity(0.07),
                    radius: 5,
                    x: -5,
                    y: 0
                )
                .offset(x: mainVM.showMenu ? -50 : 0)
                .padding(.vertical, 60)
            
            HomeView(selectedTab: $mainVM.selectedTab)
                .cornerRadius(mainVM.showMenu ? 15 : 0)
            
        }
        // Scaling and Moving the View
        .scaleEffect(mainVM.showMenu ? 0.84 : 1)
        .offset(x: mainVM.showMenu ? getRect().width - 120 : 0)
        .ignoresSafeArea()
        .overlay(
            ShowMenuButtonView(),
            alignment: .topLeading
        )
    }
}
