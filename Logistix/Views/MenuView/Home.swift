//
//  Home.swift
//  Logistix
//
//  Created by Paul Makey on 13.05.24.
//

import SwiftUI

struct Home: View {
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
            
            NewOrderView(selectedWeight: .belowOneHundred)
                .tag("Новый заказ")
            
            ContactUsView()
                .tag("Связаться с нами")
        }
    }
}

#Preview {
    OrdersView()
}

// All Subviews
struct HomePage: View {
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 20) {
                Image("pic")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(
                        width: getRect().width - 50,
                        height: 400
                    )
                    .cornerRadius(20)
                
                VStack(alignment: .leading, spacing: 5) {
                    Text("Name Surname")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundStyle(.primary)
                    
                    Text("bla bla bla")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundStyle(.gray)
                }
            }
        }
    }
}

struct History: View {
    var body: some View {
        NavigationStack {
            Text("History")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .foregroundStyle(.primary)
                .navigationTitle("History")
        }
    }
}

struct Settings: View {
    var body: some View {
        NavigationStack {
            Text("Settings")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .foregroundStyle(.primary)
                .navigationTitle("Settings")
        }
    }
}

struct Help: View {
    var body: some View {
        NavigationStack {
            Text("Help")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .foregroundStyle(.primary)
                .navigationTitle("Help")
        }
    }
}

struct Notifications: View {
    var body: some View {
        NavigationStack {
            Text("Notifications")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .foregroundStyle(.primary)
                .navigationTitle("Notifications")
        }
    }
}
