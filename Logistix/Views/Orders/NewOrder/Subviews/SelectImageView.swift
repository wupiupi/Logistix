import SwiftUI
import PhotosUI

struct SelectImageView: View {
    @EnvironmentObject private var newOrderVM: NewOrderViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Фото посылки")
                .font(.title3)
                .fontWeight(.bold)
                .foregroundStyle(.text)
            
            VStack {
                if let selectedImage = newOrderVM.selectedImage {
                    Image(uiImage: selectedImage)
                        .resizable()
                        .scaledToFill()
                        .frame(height: 200)
                        .frame(maxWidth: .infinity)
                        .clipShape(
                            RoundedRectangle(
                                cornerRadius: CornerRadius.rectangle.rawValue
                            )
                        )
                        .overlay(
                            RoundedRectangle(
                                cornerRadius: CornerRadius.rectangle.rawValue
                            ).stroke(Color.gray.opacity(0.5), lineWidth: 1.5)
                        )
                }
                
                PhotosPicker(selection: $newOrderVM.selectedItem, matching: .images) {
                    if newOrderVM.selectedItem != nil {
                        ImageTextView(text: "Изменить фотографию")
                    } else {
                        PlaceholderImageView()
                    }
                }
                .onChange(of: newOrderVM.selectedItem) { _, newItem in
                    Task {
                        if let data = try? await newItem?.loadTransferable(type: Data.self) {
                            newOrderVM.selectedImage = UIImage(data: data)
                            newOrderVM.imageData = newOrderVM.selectedImage?.jpegData(compressionQuality: 0.8)
                        }
                    }
                }
            }
            .hAlign(.center)
        }
        .padding(.horizontal, 16)
    }
}

struct ImageTextView: View {
    let text: String
    
    var body: some View {
        Text(text)
            .font(.callout)
            .fontWeight(.semibold)
    }
}

struct PlaceholderImageView: View {
    var body: some View {
        VStack {
            Image(systemName: "camera.fill")
                .font(.system(size: 24))
                .foregroundColor(.gray)
            
            Text("Добавить фотографию")
                .font(.callout)
                .foregroundStyle(.black)
            
            Text("Форматы JPEG, JPG, PNG, HEIC до 20 МБ каждый")
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
