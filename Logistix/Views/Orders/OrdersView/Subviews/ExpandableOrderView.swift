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
                                color: Color.expandableViewMain
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

