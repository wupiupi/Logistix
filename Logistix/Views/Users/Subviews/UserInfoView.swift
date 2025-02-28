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
                 OrderButtonView(
                    title: user.role == Role.admin.rawValue
                    ? "Сделать пользователем"
                    : "Сделать администратором",
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
