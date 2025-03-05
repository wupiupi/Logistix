import SwiftUI
import PhotosUI

struct SelectImageView: View {
    @EnvironmentObject private var newOrderVM: NewOrderViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Фото посылки")
                .font(.title)
                .fontWeight(.bold)
                .foregroundStyle(.text)
                .padding(.bottom, 20)
            
            VStack {
                if let selectedImage = newOrderVM.selectedImage {
                    Image(uiImage: selectedImage)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.black, lineWidth: 2))
                }
                
                PhotosPicker(selection: $newOrderVM.selectedItem, matching: .images) {
                    newOrderVM.selectedItem != nil
                    ? ImageTextView(text: "Изменить фотографию")
                    : ImageTextView(text: "Загрузите фотографию посылки")
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
        .padding(.leading, 16)
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
