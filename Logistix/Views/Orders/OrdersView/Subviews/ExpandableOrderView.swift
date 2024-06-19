//
//  ExpandableOrderView.swift
//  Logistix
//
//  Created by Serge Broski on 5/22/24.
//

import SwiftUI

struct ExpandableOrderView: View {
    let order: Order
    
    var body: some View {
        ExpandableView(
            thumbnail: ThumbnailView(content: {
                VStack {
                    Text(order.cargoType)
                        .modifier(
                            TitleModifier(
                                font: .title,
                                fontWeight: .semibold,
                                color: Color(hex: 0x363746, alpha: 1)
                            )
                        )
                }
                .padding()
            }),
            expanded: ExpandedView(content: {
                TrackInfoView(order: order)
            })
        )
    }
}

