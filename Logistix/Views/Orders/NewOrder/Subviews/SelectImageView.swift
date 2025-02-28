import SwiftUI
import PhotosUI

struct SelectImageView: View {
    @EnvironmentObject private var newOrderVM: NewOrderViewModel
    
    var body: some View {
        VStack {
            PhotosPicker(selection: $newOrderVM.selectedItem, matching: .images) {
                Text("Загрузите фотографию груза")
            }
            .onChange(of: newOrderVM.selectedItem) { _, newItem in
                Task {
                    if let data = try? await newItem?.loadTransferable(type: Data.self) {
                        newOrderVM.selectedImage = UIImage(data: data)
                        newOrderVM.imageData = newOrderVM.selectedImage?.jpegData(compressionQuality: 0.8)
                    }
                }
            }
            
            if let selectedImage = newOrderVM.selectedImage {
                Image(uiImage: selectedImage)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.black, lineWidth: 2))
            }
        }
        .hAlign(.center)
    }
}
