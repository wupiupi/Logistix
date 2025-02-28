import SwiftUI

extension View {
    func hAlign(_ alignment: Alignment) -> some View {
        self.frame(maxWidth: .infinity, alignment: alignment)
    }
    
    func vAlign(_ alignment: Alignment) -> some View {
        self.frame(maxHeight: .infinity, alignment: alignment)
    }
    
    // Extending View to Get Screen Size
    func getRect() -> CGRect {
        UIScreen.main.bounds
    }
}
