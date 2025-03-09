import SwiftUI

struct NoImageView: View {
    var body: some View {
        VStack {
            Image(systemName: "camera.fill")
                .font(.system(size: 24))
                .foregroundColor(.gray)
            
            Text("Нет фотографии")
                .font(.callout)
                .foregroundStyle(.black)
        }
        .frame(height: 200)
        .frame(maxWidth: .infinity)
        .background(Color.gray.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: CornerRadius.rectangle.rawValue))
        .overlay(
            RoundedRectangle(cornerRadius: CornerRadius.rectangle.rawValue)
                .stroke(Color.gray.opacity(0.5), lineWidth: 1)
        )
    }
}
