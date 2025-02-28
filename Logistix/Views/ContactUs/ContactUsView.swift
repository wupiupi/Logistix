import SwiftUI

struct ContactUsView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    ContactUsFieldsView()
                    ContactUsButtonView()
                }
                .padding()
                .navigationTitle("Связаться с нами")
            }
        }
    }
}
