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
                                font: .headline,
                                fontWeight: .semibold,
                                color: .text
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
