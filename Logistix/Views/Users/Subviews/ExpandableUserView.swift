//
//  ExpandableUserView.swift
//  Logistix
//
//  Created by Paul Makey on 28.05.24.
//

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
                                 fontWeight: .semibold
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
