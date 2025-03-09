import SwiftUI

struct InputView: View {
    @Binding var text: String
    let title: String
    let placeholder: String
    var isSecureField = false
    var isNumPad = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.headline)
                .foregroundStyle(.gray)
            
            if isSecureField {
                SecureField(placeholder, text: $text)
                    .modifier(InputViewModifier())
            } else {
                TextField(placeholder, text: $text)
                    .keyboardType(isNumPad ? .numberPad : .default)
                    .modifier(InputViewModifier())
            }
        }
    }
}

struct InputViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundStyle(.black)
            .frame(
                height: 50
            )
            .padding(.leading, 16)
            .background {
                RoundedRectangle(cornerRadius: CornerRadius.rectangle.rawValue)
                    .shadow(radius: 3, x: 0, y: -1)
                    .foregroundStyle(
                        Color.menuText
                    )
                    .background {
                        RoundedRectangle(cornerRadius: CornerRadius.rectangle.rawValue)
                            .stroke(
                                Color(
                                    hex: 0xDDDDDD,
                                    alpha: 1
                                ),
                                lineWidth: 3
                            )
                    }
            }
    }
}
