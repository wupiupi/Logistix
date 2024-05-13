//
//  MainView.swift
//  Logistix
//
//  Created by Paul Makey on 13.05.24.
//

import SwiftUI

struct MainView: View {
    
    // Selected Tab
    @State private var selectedTab = "Заказы"
    @State private var showMenu = false
    
    var body: some View {
        ZStack {
            Color.main
                .ignoresSafeArea()
            
            /// - Side Menu
            ScrollView(
                getRect().height < 750 ? .vertical : .init(),
                showsIndicators: false
            ) {
                SideMenu(selectedTab: $selectedTab)
            }
            
            ZStack {
                // Two Background Cards
                Color.white
                    .opacity(0.5)
                    .cornerRadius(showMenu ? 15 : 0)
                // Shadow
                    .shadow(
                        color: .black.opacity(0.07),
                        radius: 5,
                        x: -5,
                        y: 0
                    )
                    .offset(x: showMenu ? -25 : 0)
                    .padding(.vertical, 30)
                
                Color.white
                    .opacity(0.4)
                    .cornerRadius(showMenu ? 15 : 0)
                // Shadow
                    .shadow(
                        color: .black.opacity(0.07),
                        radius: 5,
                        x: -5,
                        y: 0
                    )
                    .offset(x: showMenu ? -50 : 0)
                    .padding(.vertical, 60)
                
                Home(selectedTab: $selectedTab)
                    .cornerRadius(showMenu ? 15 : 0)
                
            }
            // Scaling and Moving the View
            .scaleEffect(showMenu ? 0.84 : 1)
            .offset(x: showMenu ? getRect().width - 120 : 0)
            .ignoresSafeArea()
            .overlay(
                // Menu Button
                Button {
                    withAnimation(.spring()) {
                        showMenu.toggle()
                    }
                } label: {
                    
                    // Animated Drawer Button
                    VStack(spacing: 5) {
                        Capsule()
                            .fill(showMenu ? Color.white : Color.primary)
                            .frame(width: 30, height: 3)
                        // Rotating
                            .rotationEffect(.init(
                                degrees: showMenu ? -50 : 0
                            ))
                            .offset(
                                x: showMenu ? 2 : 0,
                                y: showMenu ? 9 : 0
                            )
                        
                        VStack(spacing: 5) {
                            Capsule()
                                .fill(showMenu ? Color.white : Color.primary)
                                .frame(width: 30, height: 3)
                            // Moving Up when Clicked
                            Capsule()
                                .fill(showMenu ? Color.white : Color.primary)
                                .frame(width: 30, height: 3)
                                .offset(y: showMenu ? -8 : 0)
                        }
                        .rotationEffect(.init(degrees: showMenu ? 50 : 0))
                    }
                }
                    .padding(),
                alignment: .topLeading
            )
        }
    }
}

#Preview {
    MainView()
}

// Extending View to Get Screen Size
extension View {
    func getRect() -> CGRect {
        UIScreen.main.bounds
    }
}
