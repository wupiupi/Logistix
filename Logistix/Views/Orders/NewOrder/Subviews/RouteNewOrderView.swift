import SwiftUI
import PhotosUI

struct RouteNewOrderView: View {
    @EnvironmentObject private var newOrderVM: NewOrderViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Маршрут")
                .font(.title)
                .fontWeight(.bold)
                .foregroundStyle(Color(hex: 0x363746, alpha: 1))
                .padding(.leading)
            
            VStack {
                PhotosPicker(selection: $newOrderVM.selectedItem, matching: .images) {
                    Text("Выбрать фото")
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
                }
            }
            
            VStack {
                InputView(
                    text: $newOrderVM.sourceAddress,
                    title: "Откуда:",
                    placeholder: "Адрес отправки"
                )
                
                InputView(
                    text: $newOrderVM.destinationAddress,
                    title: "Куда:",
                    placeholder: "Адрес доставки"
                )
            }
            .hAlign(.center)
        }
        .padding(.bottom, 50)
    }
}
