import SwiftUI

 struct UserInfoView: View {
     @EnvironmentObject private var usersVM: UsersViewModel
     @EnvironmentObject private var authVM: AuthViewModel
     let user: User

     var body: some View {
         VStack(alignment: .leading, spacing: 14) {
             VStack {
                 Text(user.name)
                     .modifier(
                        TitleModifier(
                            font: .headline,
                            fontWeight: .bold,
                            color: .text
                        )
                     )
             }
             .hAlign(.center)

             UserDetailsView(title: "ID", userInfo: user.id)
             UserDetailsView(title: "Почта", userInfo: user.email)
             UserDetailsView(title: "Роль", userInfo: user.role)
             if user.role == Role.driver.rawValue {
                 UserDetailsView(
                    title: "Марка автомобиля",
                    userInfo: user.auto?.brand ?? "НЕ УКАЗАНО"
                 )
                 UserDetailsView(
                    title: "Грузоподъемность",
                    userInfo: "\(user.auto?.maxWeightLimit ?? "НЕ УКАЗАНО") кг"
                 )
                 UserDetailsView(
                    title: "Регистрационный номер ТС",
                    userInfo: user.auto?.regNumber ?? "НЕ УКАЗАНО"
                 )
             }
             
             if authVM.currentUser?.id != user.id {
                 VStack {
                     OrderButtonView(
                        title: user.role == Role.admin.rawValue
                        ? "Сделать пользователем"
                        : "Сделать администратором",
                        titleColor: .green,
                        backColor: .clear) {
                            usersVM.updateUserRole(
                                id: user.id,
                                role: user.role == Role.user.rawValue
                                ? Role.admin.rawValue
                                : Role.user.rawValue
                            )
                            
                        }
                     
                     OrderButtonView(
                        title: "Удалить пользователя",
                        titleColor: .red,
                        backColor: .clear) {
                            usersVM.deleteUser(user)
                        }
                 }
                 .hAlign(.center)
             }
         }
         .padding()
     }
 }
