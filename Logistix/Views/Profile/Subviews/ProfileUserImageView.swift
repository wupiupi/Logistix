import SwiftUI
import PhotosUI

struct ProfileUserImageView: View {
    @EnvironmentObject private var userProfileVM: UserProfileViewModel
    @EnvironmentObject private var authVM: AuthViewModel
    
    var realmImage: UIImage? {
        let imageID = userProfileVM.profileImageID.isEmpty
        ? (authVM.currentUser?.profilePhotoID ?? "")
        : userProfileVM.profileImageID
        
        return userProfileVM.fetchImageFromRealm(imageID: imageID)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            VStack {
                if let realmImage {
                    Image(uiImage: realmImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .overlay(
                            Circle().stroke(
                                Color.gray.opacity(0.5),
                                lineWidth: 1.5
                            )
                        )
                }
                
                PhotosPicker(selection: $userProfileVM.selectedItem, matching: .images) {
                    if userProfileVM.selectedItem != nil || realmImage != nil {
                        ImageTextView(text: "Изменить фотографию")
                    } else {
                        ProfileImagePlaceholderView()
                    }
                }
                .onChange(of: userProfileVM.selectedItem) { _, newItem in
                    guard let newItem else { return }
                    
                    Task {
                        if let data = try? await newItem.loadTransferable(type: Data.self),
                           let uiImage = UIImage(data: data),
                           let jpegData = uiImage.jpegData(compressionQuality: 0.8) {
                            
                            userProfileVM.selectedImage = uiImage
                            userProfileVM.imageData = jpegData
                            
                            changeImageID()
                        }
                    }
                }
            }
            .hAlign(.center)
        }
        .padding(.horizontal, 16)
    }
    
    func changeImageID() {
        guard let imageData = userProfileVM.imageData else { return }
        
        // ✅ Сохраняем старый ID не из currentUser, а из локального состояния
        let oldImageID = userProfileVM.profileImageID
        
        // Генерируем новый ID
        let newImageID = UUID().uuidString
        let newRealmImage = RealmImage(imageID: newImageID, data: imageData)
        
        Task {
            await authVM.updateProfilePhotoID(
                to: newImageID,
                image: newRealmImage
            )
            
            // Удаляем старое фото по реально предыдущему ID
            if !oldImageID.isEmpty {
                userProfileVM.deleteImageFromRealm(imageID: oldImageID)
            }
            
            // Обновляем локальный ID
            userProfileVM.profileImageID = newImageID
        }
    }
    
}
