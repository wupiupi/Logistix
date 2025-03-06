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
                .font(.headline)
                .foregroundStyle(titleColor)
                .padding(10)
                .background {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(backColor)
                }
        }
    }
}
