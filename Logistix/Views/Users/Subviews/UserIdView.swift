import SwiftUI

struct UserIdView: View {
    @EnvironmentObject private var usersVM: UsersViewModel
    
     let user: User

     var body: some View {
         VStack(alignment: .leading) {
             HStack {
                 Text(user.email)
                     .font(.headline)
                     .foregroundStyle(
                        usersVM.getRoleColor(forRole: user.role).mainColor
                     )
                     .padding([.top, .bottom], 8)
                     .padding([.leading, .trailing], 8)
                     .background {
                         RoundedRectangle(cornerRadius: 10)
                             .fill(usersVM.getRoleColor(forRole: user.role).backgroundColor)
                     }

                 Spacer()
             }
         }
     }
 }
