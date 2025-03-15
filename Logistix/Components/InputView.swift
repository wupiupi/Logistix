import SwiftUI

struct InputView: View {
    @Binding var text: String
    let title: String
    let placeholder: String
    var isSecureField = false
    var isNumPad = false
    var isInvalid = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.headline)
                .foregroundStyle(.gray)
            
            if isSecureField {
                SecureField(placeholder, text: $text)
                    .modifier(InputViewModifier(isInvalid: isInvalid))
            } else {
                TextField(placeholder, text: $text)
                    .keyboardType(isNumPad ? .numberPad : .default)
                    .modifier(InputViewModifier(isInvalid: isInvalid))
            }
        }
    }
}

struct InputViewModifier: ViewModifier {
    var isInvalid: Bool

    func body(content: Content) -> some View {
        content
            .foregroundStyle(.black)
            .frame(height: 50)
            .padding(.leading, 16)
            .background {
                RoundedRectangle(cornerRadius: CornerRadius.rectangle.rawValue)
                    .shadow(radius: 3, x: 0, y: -1)
                    .foregroundStyle(Color.menuText)
                    .background {
                        RoundedRectangle(cornerRadius: CornerRadius.rectangle.rawValue)
                            .stroke(
                                isInvalid 
                                ? Color.red
                                : Color(hex: 0xDDDDDD, alpha: 1),
                                lineWidth: 3
                            )
                    }
            }
    }
}
