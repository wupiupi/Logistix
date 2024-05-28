//
//  UserInfoView.swift
//  Logistix
//
//  Created by Paul Makey on 28.05.24.
//

import SwiftUI

struct UserInfoView: View {
    let user: User
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            Text("Пользователь: \(user.id)")
                .modifier(TitleModifier(font: .title3, fontWeight: .bold))
            
            UserDetailsView(title: "ID", userInfo: user.id)
            UserDetailsView(title: "ФИО", userInfo: user.name)
            UserDetailsView(title: "Почта", userInfo: user.email)
            UserDetailsView(title: "Роль", userInfo: user.role)
        }
        .padding()
        .hAlign(.center)
    }
}
