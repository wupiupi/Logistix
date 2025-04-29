import SwiftUI

struct ProfileDetailsView: View {
    let title: String
    let info: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(title):")
                .font(.subheadline)
                .foregroundStyle(.black)
            
            Text(info)
                .font(.body)
                .foregroundStyle(.gray)
        }
    }
}
