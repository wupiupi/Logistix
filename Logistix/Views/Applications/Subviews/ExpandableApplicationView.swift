//
//  ExpandableApplicationView.swift
//  Logistix
//
//  Created by Serge Broski on 5/22/24.
//

import SwiftUI

struct ExpandableApplicationView: View {
    let application: Application
    
    var body: some View {
        ExpandableView(
            thumbnail: ThumbnailView(content: {
                VStack {
                    Text(application.company)
                        .modifier(
                            TitleModifier(
                                font: .title,
                                fontWeight: .semibold,
                                color: Color.expandableViewMain
                            )
                        )
                }
                .padding()
            }),
            expanded: ExpandedView(content: {
                ApplicationInfoView(application: application)
            })
        )
    }
}
