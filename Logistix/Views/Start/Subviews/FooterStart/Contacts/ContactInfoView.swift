import SwiftUI

struct ContactInfoView: View {
    let image: String
    let text: String
    
    var body: some View {
        HStack {
            Image(image)
                .resizable()
                .frame(width: 20, height: 25)
            
            Text(text)
        }
    }
}
