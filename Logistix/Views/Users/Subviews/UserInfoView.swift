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
             Text("Пользователь: \(user.name)")
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
             if !user.auto.isEmpty {
                 UserDetailsView(title: "Автомобиль", userInfo: user.auto)
             }
             
             if authVM.currentUser?.id != user.id {
                 OrderButtonView(
                    title: user.role == Role.user.rawValue
                    ? "Сделать администратором"
                    : "Сделать пользователем",
                    titleColor: .white,
                    backColor: .green) {
                        usersVM.updateUserRole(
                            id: user.id,
                            role: user.role == Role.user.rawValue
                            ? Role.admin.rawValue
                            : Role.user.rawValue
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
