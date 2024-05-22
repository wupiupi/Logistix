//
//  HomeView.swift
//  Logistix
//
//  Created by Paul Makey on 13.05.24.
//

import SwiftUI

struct HomeView: View {
    @Binding var selectedTab: String
    
    // Hiding Tab Bar
    init(selectedTab: Binding<String>) {
        self._selectedTab = selectedTab
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        // Tab View with Tabs
        TabView(selection: $selectedTab) {
            
            // Views
            OrdersView()
                .tag("Заказы")
            
            NewOrderView()
                .tag("Новый заказ")
            
            ContactUsView()
                .tag("Связаться с нами")
            
            ApplicationsView()
                .tag("Заявки")
        }
    }
}
