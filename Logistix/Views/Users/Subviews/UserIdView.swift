import SwiftUI

struct UserIdView: View {
     let user: User

     var body: some View {
         VStack(alignment: .leading) {
             HStack {
                 Text("№ \(user.id)")
                     .font(.headline)
                     .foregroundStyle(Color(hex: 0x00CCA6, alpha: 1))
                     .padding([.top, .bottom], 8)
                     .padding([.leading, .trailing], 8)
                     .background {
                         RoundedRectangle(cornerRadius: 10)
                             .fill(.statusGreenBackground)
                     }

                 Spacer()
             }
         }
     }
 }
