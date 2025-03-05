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
        
        FeatureView(
            imageName: "insurance",
            text: "Своя служба безопасности",
            textColor: .white,
            backgroundColor: .statusGreen
        )
    }
}
