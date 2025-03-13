import SwiftUI

struct CustomButtonView: View {
    let title: String
    var systemImage: String = ""
    
    var body: some View {
        HStack {
            Text(title)
                .font(.title2)
                .foregroundStyle(.white)
                .fontWeight(.semibold)
            
            Spacer()
            
            Image(systemName: systemImage)
                .imageScale(.small)
                .font(.title)
                .foregroundStyle(.white)
        }
        .padding(.top, 10)
        .padding(.bottom, 5)
        .padding([.leading, .trailing], 16)
        .foregroundStyle(.white)
        .background {
            RoundedRectangle(cornerRadius: CornerRadius.rectangle.rawValue)
                .fill(.greenButton)
                .frame(height: 40)
                .shadow(color: .black, radius: 15)
        }
    }
}
