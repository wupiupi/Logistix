import SwiftUI

struct ExpandableUserView: View {
     let user: User

     var body: some View {
         ExpandableView(
             thumbnail: ThumbnailView(content: {
                 VStack {
                     Text(user.email)
                         .modifier(
                             TitleModifier(
                                 font: .title3,
                                 fontWeight: .semibold,
                                 color: .text
                             )
                         )
                 }
                 .padding()
             }),
             expanded: ExpandedView(content: {
                 UserInfoView(user: user)
             })
         )
     }
 }
