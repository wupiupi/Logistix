//
//  ExpandedUserInfoView.swift
//  Logistix
//
//  Created by Paul Makey on 28.05.24.
//

import SwiftUI

struct ExpandedUserInfoView: View {
    @EnvironmentObject private var usersVM: UsersViewModel
    
    let user: User
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            Text("Пользователь: \(user.id)")
                .modifier(TitleModifier(font: .title3, fontWeight: .bold))
            
            UserDetailsView(title: "ID", userInfo: user.id)
            UserDetailsView(title: "ФИО", userInfo: user.name)
            UserDetailsView(title: "Почта", userInfo: user.email)
            UserDetailsView(title: "Роль", userInfo: user.role)
            
            OrderButtonView(
                title: user.role == "user" ? "Сделать администратором" : "Сделать пользователем",
                titleColor: .white,
                backColor: .green) {
                    usersVM.updateUserRole(
                        id: user.id,
                        role: user.role == "user" ? .admin : .user
                    )
                }
        }
        .padding()
        .hAlign(.center)
    }
}
