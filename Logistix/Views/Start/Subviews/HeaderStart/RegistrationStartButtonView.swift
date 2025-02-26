import SwiftUI

struct RegistrationStartButtonView: View {
    var body: some View {
        NavigationLink {
            RegistrationView()
        } label: {
            CustomButtonView(
                title: "Регистрация",
                systemImage: "arrowshape.right.fill"
            )
        }
    }
}
