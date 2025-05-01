import PhotosUI
import SwiftUI
import RealmSwift
import Firebase

final class UserProfileViewModel: ObservableObject {
    @Published var selectedImage: UIImage?
    @Published var selectedItem: PhotosPickerItem?
    @Published var imageData: Data?
    @Published var profileImageID: String = ""
    
    @Published var newValue = ""
    @Published var confirmPassword = ""
    
    @Published var showNameAlert = false
    @Published var showPassAlert = false
    @Published var alertMessage: String = ""
    @Published var showResultAlert = false
    
    @Published var displayedName: String = ""
    
    func fetchImageFromRealm(imageID: String) -> UIImage? {
        let realm = try! Realm()
        let realmImage = realm.objects(RealmImage.self).filter("imageID == %@", imageID).first
        if let imageData = realmImage?.data, let uiImage = UIImage(data: imageData) {
            return uiImage
        }
        return nil
    }
    
    func deleteImageFromRealm(imageID: String) {
        let realm = try! Realm()
        if let oldImage = realm.objects(RealmImage.self).filter("imageID == %@", imageID).first {
            try? realm.write {
                realm.delete(oldImage)
            }
            print("🗑️ Удалено изображение с ID: \(imageID)")
        } else {
            print("❌ Изображение с ID \(imageID) не найдено в Realm")
        }
    }
    
    func updateField(fieldKey: String, newValue: String) async {
        guard let userID = Auth.auth().currentUser?.uid else { return }

        let db = Firestore.firestore()

        // Проверка имени
        if fieldKey == "name" {
            let containsDigits = newValue.rangeOfCharacter(from: .decimalDigits) != nil
            if containsDigits || newValue.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                alertMessage = "Имя не должно содержать цифры или быть пустым"
                showResultAlert = true
                return
            }
        }

        // Проверка пароля
        if fieldKey == "pass" {
            if newValue != confirmPassword {
                alertMessage = "Пароли не совпадают"
                showResultAlert = true
                return
            }
            if newValue.count < 6 {
                alertMessage = "Пароль должен быть не менее 6 символов"
                showResultAlert = true
                return
            }
        }

        do {
            if fieldKey == "pass" {
                try await Auth.auth().currentUser?.updatePassword(to: newValue)
                await MainActor.run {
                    alertMessage = "Пароль успешно обновлён"
                }
            } else {
                try await db.collection("users").document(userID).updateData([
                    "name": newValue
                ])
                await MainActor.run {
                    displayedName = newValue
                alertMessage = "Имя успешно обновлено. Данным требуется время на изменение!"
                }
            }
        } catch {
            await MainActor.run {
                if let err = error as NSError?,
                   err.code == AuthErrorCode.requiresRecentLogin.rawValue {
                    alertMessage = "Для изменения пароля требуется повторная авторизация"
                } else {
                    alertMessage = "Ошибка: \(error.localizedDescription)"
                }
            }
        }

        await MainActor.run {
            showResultAlert = true
        }
    }
}
