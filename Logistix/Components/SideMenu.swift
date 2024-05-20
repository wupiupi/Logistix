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
    
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            // Padding top for Top Close Button
            VStack(alignment: .leading, spacing: 6) {
                Text(viewModel.currentUser?.email ?? "")
                    .font(.title)
                    .fontWeight(.heavy)
                    .foregroundStyle(.white)
                    .padding(.top, 50)
            }
            
            // Tab Buttons
            VStack(alignment: .leading, spacing: 10) {
                if viewModel.currentUser?.role == "admin" {
                    TabButton(
                        image: "list.star",
                        title: "Заказы",
                        selectedTab: $selectedTab,
                        animation: animation
                    )
                    
                    TabButton(
                        image: "folder",
                        title: "Заявки",
                        selectedTab: $selectedTab,
                        animation: animation
                    )
                } else {
                    TabButton(
                        image: "list.star",
                        title: "Заказы",
                        selectedTab: $selectedTab,
                        animation: animation
                    )
                    
                    TabButton(
                        image: "pencil.and.list.clipboard",
                        title: "Новый заказ",
                        selectedTab: $selectedTab,
                        animation: animation
                    )
                    
                    TabButton(
                        image: "phone.fill",
                        title: "Связаться с нами",
                        selectedTab: $selectedTab,
                        animation: animation
                    )
                }
                
            }
            .padding(.leading, -15)
            .padding(.top, 50)
            
            Spacer()
            
            // Sign Out Button
            VStack(alignment: .leading, spacing: 6) {
                TabButton(
                    image: "rectangle.righthalf.inset.fill.arrow.right",
                    title: "Выход из аккаунта",
                    action: { viewModel.signOut() },
                    selectedTab: .constant(""),
                    animation: animation
                )
                .padding(.leading, -15)
                
                Text("Версия приложения 1.0.0")
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
    MainView()
}
