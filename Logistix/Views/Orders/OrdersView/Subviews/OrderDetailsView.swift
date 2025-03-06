import SwiftUI

struct OrderDetailsView: View {
    let title: String
    let orderInfo: String
    var systemImageName: String? = nil
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(title):")
                .font(.subheadline)
                .foregroundStyle(.black)
            
            if title == "Стоимость" {
                Text("\(orderInfo) BYN")
                    .font(.body)
                    .foregroundStyle(.gray)
            } else {
                Text(orderInfo)
                    .font(.body)
                    .foregroundStyle(.gray)
            }
        }
    }
}
