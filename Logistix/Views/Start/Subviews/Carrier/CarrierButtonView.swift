import SwiftUI

struct CarrierButtonView: View {
    var body: some View {
        NavigationLink {
            RegistrationView()
        } label: {
            Text("Присоединяйтесь")
                .font(.title2)
                .padding(.leading, 16)
                .padding(.trailing, 16)
                .padding(.top, 15)
                .padding(.bottom, 10)
                .foregroundStyle(.white)
                .background {
                    Capsule()
                        .fill(.statusGreen)
                }
        }
        .frame(width: UIScreen.main.bounds.width - 32)
    }
}

#Preview {
    CarrierButtonView()
}
