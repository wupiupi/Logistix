import SwiftUI

struct LoginStartButtonView: View {
    var body: some View {
        NavigationLink {
            LoginView()
        } label: {
            CustomButtonView(
                title: "Вход",
                systemImage: "arrowshape.right.fill"
            )
        }
    }
}
