import Foundation
import Firebase
import FirebaseFirestoreSwift
import CryptoKit
import RealmSwift

protocol ValidationFormProtocol {
    var formIsValid: Bool { get }
}

@MainActor
final class AuthViewModel: ObservableObject {
    // Tells us if user logged in or not
    @Published var currentUser: User?
    
    // Our logged in user object
    @Published var userSession: FirebaseAuth.User?
    
    // Displaying an alert with a corresponding error
    @Published var showAlert = false
    @Published var isEmailTaken = false
    @Published var alertMessage = ""
    
    @Published var isLoadingOrders = false
    
    init() {
        userSession = Auth.auth().currentUser
        
        Task {
            await fetchUser()
        }
    }
    
    // MARK: - AUTHORIZATION
    func signIn(
        withEmail email: String,
        password: String
    ) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            userSession = result.user
            await fetchUser()
        } catch {
            print("DEBUG: failed to sign in with error: \(error)")
            showAlert.toggle()
            alertMessage = "Ошибка! Пожалуйста, проверьте корректность введённых данных"
        }
    }
    
    func createUser(
        withEmail email: String,
        password: String,
        fullName: String,
        role: String,
        auto: Auto?
    ) async throws {
        
        let hashedPass = hashPassword(password)
        
        do {
            
            // Creating a user using firebase code
            let result = try await Auth.auth().createUser(
                withEmail: email,
                password: hashedPass
            )
            userSession = result.user
            
            // Creating our User data model
            let user = User(
                id: result.user.uid,
                auto: auto,
                email: email,
                name: fullName,
                role: role, 
                profilePhotoID: "",
                orders: [],
                applications: []
            )
                        
            // Encoding our user
            let encodedUser = try Firestore.Encoder().encode(user)
            
            // Uploading data to the firestore
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
            
            // Fetching user after we created a user
            await fetchUser()
        } catch {
            isEmailTaken.toggle()
            alertMessage = error.localizedDescription
            print("DEBUG: Failed to create user with error: \(error)")
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut() // signs user out on backend
            userSession = nil // wipes out user session and takes us back to login screen
            currentUser = nil // wipes out current user data model
        } catch {
            print("Failed to sign out with error: \(error)")
        }
    }
    
    func fetchUser() async {
        isLoadingOrders = true
        defer { isLoadingOrders = false }
        
        guard let uid = Auth.auth().currentUser?.uid else { 
            isLoadingOrders = false
            return
        }
        
        guard let snapshot = try? await Firestore
            .firestore()
            .collection("users")
            .document(uid)
            .getDocument()
        else {
            return
        }
        
        currentUser = try? snapshot.data(as: User.self)
    }
    
    // MARK: - ORDERS
    func addOrderToUser(order: Order, image: RealmImage? = nil) async {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let db = Firestore.firestore()
        let userRef = db.collection("users").document(uid)
        
        do {
            let orderData = try Firestore.Encoder().encode(order)
            
            try await userRef.updateData([
                "orders": FieldValue.arrayUnion([orderData])
            ])
            
            if image != nil {
                saveImageToRealm(imageID: image?.imageID ?? "", imageData: image?.data)
            }
            
            await fetchUser()
        } catch {
            print("Error encoding order: \(error)")
        }
    }
    
    // User Profile Image
    func updateProfilePhotoID(
        to newPhotoID: String,
        image: RealmImage? = nil
    ) async {
        guard let uid = Auth.auth().currentUser?.uid else {
            print("❌ Не удалось получить uid пользователя")
            return
        }

        let db = Firestore.firestore()
        let userRef = db.collection("users").document(uid)

        do {
            try await userRef.updateData([
                "profilePhotoID": newPhotoID
            ])
            print("✅ profilePhotoID успешно обновлён")

            if let image = image {
                saveImageToRealm(imageID: image.imageID, imageData: image.data)
            }
        } catch {
            print("❌ Ошибка при обновлении profilePhotoID: \(error.localizedDescription)")
        }
    }
    
    private func saveImageToRealm(imageID: String, imageData: Data?) {
        let realm = try! Realm()
        let newImage = RealmImage(imageID: imageID, data: imageData)
        
        try! realm.write({
            realm.add(newImage)
        })
        
        if let realmURL = Realm.Configuration.defaultConfiguration.fileURL {
                    let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
                    let fileURL = documentDirectory?.appendingPathComponent(realmURL.lastPathComponent)
                    print("Realm file URL: \(fileURL?.path ?? "")")
                }
    }
    
    // MARK: - APPLICATIONS
    func addApplicationToUser(application: Application) async {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let db = Firestore.firestore()
        let userRef = db.collection("users").document(uid)
        
        do {
            let applicationData = try Firestore.Encoder().encode(application)
            
            try await userRef.updateData([
                "applications": FieldValue.arrayUnion([applicationData])
            ])
        } catch {
            print("Error encoding application: \(error)")
        }
    }
    
    func hashPassword(_ password: String) -> String {
        let data = Data(password.utf8)
        let hash = SHA256.hash(data: data)
        return hash.compactMap { String(format: "%.02x", $0) }.joined()
    }
}
