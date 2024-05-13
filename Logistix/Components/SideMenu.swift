//
//  SideMenu.swift
//  Logistix
//
//  Created by Paul Makey on 13.05.24.
//

import SwiftUI

struct SideMenu: View {
    @Binding var selectedTab: String
    @Namespace var animation
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            
            // Profile Pic
            Image("person")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 70, height: 70)
            
            // Padding top for Top Close Button
                .padding(.top, 50)
            
            VStack(alignment: .leading, spacing: 6) {
                Text("Name Surname")
                    .font(.title)
                    .fontWeight(.heavy)
                    .foregroundStyle(.white)
                
                Button {
                    
                } label: {
                    Text("View Profile")
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .opacity(0.7)
                        
                }
            }
            
            // Tab Buttons
            VStack(alignment: .leading, spacing: 10) {
                TabButton(
                    image: "house",
                    title: "Home",
                    selectedTab: $selectedTab,
                    animation: animation
                )
                
                TabButton(
                    image: "clock.arrow.circlepath",
                    title: "History",
                    selectedTab: $selectedTab,
                    animation: animation
                )
                
                TabButton(
                    image: "bell.badge",
                    title: "Notifications",
                    selectedTab: $selectedTab,
                    animation: animation
                )
                
                TabButton(
                    image: "gearshape.fill",
                    title: "Settings",
                    selectedTab: $selectedTab,
                    animation: animation
                )
                
                TabButton(
                    image: "questionmark.circle",
                    title: "Help",
                    selectedTab: $selectedTab,
                    animation: animation
                )
            }
            .padding(.leading, -15)
            .padding(.top, 50)
            
            Spacer()
            
            // Sign Out Button
            VStack(alignment: .leading, spacing: 6) {
                TabButton(
                    image: "rectangle.righthalf.inset.fill.arrow.right",
                    title: "Log out",
                    selectedTab: .constant(""),
                    animation: animation
                )
                .padding(.leading, -15)
                
                Text("App Version 1.0.0")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .opacity(0.6)
            }
            
        }
        .padding()
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity,
            alignment: .topLeading
        )
    }
}

#Preview {
    OrdersView()
}
