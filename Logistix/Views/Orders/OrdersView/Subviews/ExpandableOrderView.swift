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
                                font: .headline,
                                fontWeight: .semibold,
                                color: .text
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

