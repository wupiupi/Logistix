import SwiftUI

struct ContactUsView: View {
    var body: some View {
        VStack {
            Text("Связаться с нами")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .padding(.bottom, 6)
            
            ContactUsFieldsView()
            
            ContactUsButtonView()
        }
    }
}
