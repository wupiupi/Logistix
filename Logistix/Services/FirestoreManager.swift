import Foundation
import FirebaseFirestore

final class FirestoreManager {
    private let db = Firestore.firestore()
    static let shared = FirestoreManager()
    
    private init() {}
}
