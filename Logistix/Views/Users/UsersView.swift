//
//  UsersView.swift
//  Logistix
//
//  Created by Paul Makey on 28.05.24.
//

import SwiftUI

struct UsersView: View {
    @EnvironmentObject private var usersVM: UsersViewModel
    @EnvironmentObject private var ordersVM: OrdersViewModel
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    UsersTitle()
                    
                    ForEach(usersVM.users) { user in
                        
                        Divider()
                        
                        // Order ID & Date of Loading
                        UserIdView(user: user)
                        
                        // Expands the details of the order
                        ExpandableUserView(user: user)
                    }
                }
                .padding()
            }
            .navigationTitle("Logistix")
            .toolbarBackground(
                LinearGradient(
                    colors: [
                        Color(hex: 0x00CCA6, alpha: 1),
                        Color(hex: 0x29B197, alpha: 0.5)
                    ],
                    startPoint: .leading,
                    endPoint: .trailing
                ),
                for: .navigationBar
            )
        }
    }
}

struct UsersTitle: View {
    
    var body: some View {
        Text("Пользователи")
            .modifier(
                TitleModifier(
                    font: .largeTitle,
                    fontWeight: .semibold
                )
            )
    }
}
