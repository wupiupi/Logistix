import SwiftUI

struct CustomDatePickerView: View {
    @Binding var date: Date?
    
    var body: some View {
        DatePickerTextFieldView(
            placeholder: "Выберите дату",
            date: $date
        )
        .font(.title)
        .padding(.horizontal, 16)
        .frame(width: UIScreen.main.bounds.width - 32, height: 46)
        .background {
            RoundedRectangle(cornerRadius: CornerRadius.rectangle.rawValue)
                .fill(.white)
                .background {
                    RoundedRectangle(cornerRadius: CornerRadius.rectangle.rawValue)
                        .stroke()
                        .foregroundStyle(.completed)
                }
        }
    }
}
