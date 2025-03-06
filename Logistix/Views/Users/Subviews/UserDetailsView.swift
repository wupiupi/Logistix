import SwiftUI

struct UserDetailsView: View {
    let title: String
    let userInfo: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(title):")
                .font(.subheadline)
                .foregroundStyle(.black)
            
            Text(userInfo)
                .font(.body)
                .foregroundStyle(.gray)
        }
    }
}
