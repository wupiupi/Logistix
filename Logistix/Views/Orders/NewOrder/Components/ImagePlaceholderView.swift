import SwiftUI

struct ImagePlaceholderView: View {
    var body: some View {
        VStack {
            Image(systemName: "camera.fill")
                .font(.system(size: 24))
                .foregroundColor(.gray)
            
            Text("Добавить фотографию")
                .font(.callout)
                .foregroundStyle(.black)
            
            Text("Форматы JPEG, JPG, PNG, HEIC\nдо 20 МБ каждый")
                .font(.footnote)
                .foregroundStyle(.gray)
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
