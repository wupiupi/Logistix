import SwiftUI

struct TabButton: View {
    @EnvironmentObject private var mainVM: MainViewModel
    
    var image: String
    var title: String
    var action: (() -> Void)?
    
    // Selected Tab
    @Binding var selectedTab: String
    // For Hero Animation Slide
    var animation: Namespace.ID
    
    var body: some View {
        Button {
            (action ?? {})()
            withAnimation(.spring()) {
                selectedTab = title
                mainVM.showMenu = false
            }
        } label: {
            HStack(spacing: 15) {
                Image(systemName: image)
                    .font(.title2)
                    .frame(width: 30)
                
                Text(title)
                    .fontWeight(.semibold)
            }
            .foregroundStyle(
                selectedTab == title ? Color.menuBackground : Color.menuText
            )
            .padding(.vertical, 12)
            .padding(.horizontal, 10)
            
            // Max Frame
            .frame(maxWidth: getRect().width - 170, alignment: .leading)
            .background(
                
                // Hero Animation
                ZStack {
                    if selectedTab == title {
                        Color.menuText
                            .opacity(selectedTab == title ? 1 : 0)
                            .clipShape(
                                CustomCorners(
                                    corners: [.topRight, .bottomRight],
                                    radius: CornerRadius.rectangle.rawValue
                                )
                            )
                            .matchedGeometryEffect(id: "TAB", in: animation)
                    }
                }
                
            )
        }
    }
}
