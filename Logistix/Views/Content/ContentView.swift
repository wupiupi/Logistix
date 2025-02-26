import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var authVM: AuthViewModel
    
    var body: some View {
        Group {
            if authVM.currentUser != nil {
                MainView()
            } else {
                StartView()
            }
        }
    }
}
