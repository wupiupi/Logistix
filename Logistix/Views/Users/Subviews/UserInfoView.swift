//
//  UserInfoView.swift
//  Logistix
//
//  Created by Paul Makey on 30.05.24.
//

import SwiftUI

 struct UserInfoView: View {
     @EnvironmentObject private var usersVM: UsersViewModel
     @EnvironmentObject private var authVM: AuthViewModel
     let user: User

     var body: some View {
         VStack(alignment: .center, spacing: 20) {
             Text("Пользователь: \(user.id)")
                 .modifier(
                    TitleModifier(
                        font: .title3,
                        fontWeight: .bold,
                        color: Color(hex: 0x363746, alpha: 1)
                    )
                 )

             UserDetailsView(title: "ID", userInfo: user.id)
             UserDetailsView(title: "ФИО", userInfo: user.name)
             UserDetailsView(title: "Почта", userInfo: user.email)
             UserDetailsView(title: "Роль", userInfo: user.role)
             
             if authVM.currentUser?.id != user.id {
                 OrderButtonView(
                    title: user.role == "user" ? "Сделать администратором" : "Сделать пользователем",
                    titleColor: .white,
                    backColor: .green) {
                        usersVM.updateUserRole(
                            id: user.id,
                            role: user.role == "user" ? .admin : .user
                        )
                        
                    }
                 
                 OrderButtonView(
                    title: "Удалить пользователя",
                    titleColor: .white,
                    backColor: .red) {
                        usersVM.deleteUser(user)
                    }
             }
         }
         .padding()
         .hAlign(.center)
     }
 }
