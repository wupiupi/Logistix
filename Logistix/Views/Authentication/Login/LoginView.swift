import SwiftUI

struct LoginView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 30) {
                Text("Привет 👋🏻")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                LoginFieldsView()
                
                LoginButtonView()
            }
            .padding(.bottom, 100)
        }
    }
}
