import SwiftUI

struct OrderButtonView: View {    
    let title: String
    let titleColor: Color
    let backColor: Color
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(title)
                .font(.subheadline)
                .foregroundStyle(titleColor)
                .padding(10)
                .background {
                    RoundedRectangle(cornerRadius: CornerRadius.rectangle.rawValue)
                        .fill(backColor)
                }
        }
    }
}
