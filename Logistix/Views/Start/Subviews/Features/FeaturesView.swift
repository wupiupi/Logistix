import SwiftUI

struct FeaturesView: View {
    var body: some View {
        FeatureView(
            imageName: "handshake",
            text: "Более 6 000 водителей и поставщиков работают с нами"
        )
        
        
        FeatureView(
            imageName: "truck",
            text: "Свыше 100 000 сделок в год"
        )
        
        ArrowsView()
        
        FeatureView(
            imageName: "insurance",
            text: "Своя служба безопасности",
            textColor: .white,
            backgroundColor: .mainGreen
        )
    }
}

struct ArrowsView: View {
    var body: some View {
        VStack {
            Image("arrows")
                .resizable()
                .frame(width: 80, height: 80)
                .rotationEffect(.degrees(90))
                .foregroundStyle(.mainGreen)
        }
    }
}
