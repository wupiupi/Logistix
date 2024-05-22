//
//  ExpandableApplicationView.swift
//  Logistix
//
//  Created by Serge Broski on 5/22/24.
//

import SwiftUI

struct ExpandableApplicationView: View {
    let application: ApplicationForm
    
    var body: some View {
        ExpandableView(
            thumbnail: ThumbnailView(content: {
                VStack {
                    Text("Открыть")
                        .modifier(
                            TitleModifier(
                                font: .title,
                                fontWeight: .semibold
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

#Preview {
    ExpandableApplicationView(
        application: ApplicationForm()
    )
}
