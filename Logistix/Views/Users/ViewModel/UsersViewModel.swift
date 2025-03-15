import SwiftUI
import FirebaseFirestore

@MainActor
final class UsersViewModel: ObservableObject {
    @Published var searchTerm = ""
    @Published private(set) var users: [User] = []

    private let db = Firestore.firestore()
    private var listener: ListenerRegistration?

    init() {
        setupListener()
    }

    deinit {
        listener?.remove()  // Отключаем listener при удалении
    }

    var filteredUsers: [User] {
        guard !searchTerm.isEmpty else { return users }
        return users.filter { $0.id.localizedStandardContains(searchTerm) }
    }

    private func setupListener() {
        listener = db.collection("users").addSnapshotListener { [weak self] snapshot, error in
            guard let self = self, let snapshot else {
                print("Error listening for users: \(String(describing: error))")
                return
            }

            self.users = snapshot.documents.compactMap { doc -> User? in
                var auto: Auto? = nil
                if let autoData = doc["auto"] as? [String: Any] {
                    auto = Auto(
                        brand: autoData["brand"] as? String ?? "",
                        maxWeightLimit: autoData["maxWeightLimit"] as? String ?? "",
                        regNumber: autoData["regNumber"] as? String ?? ""
                    )
                }

                return User(
                    id: doc["id"] as? String ?? "",
                    auto: auto,
                    email: doc["email"] as? String ?? "",
                    name: doc["name"] as? String ?? "",
                    pass: doc["pass"] as? String ?? "",
                    role: doc["role"] as? String ?? "",
                    orders: [],
                    applications: []
                )
            }
        }
    }

    func updateUserRole(id: String, role: String) {
        db.collection("users").document(id).updateData(["role": role]) { error in
            if let error {
                print("Error updating role: \(error)")
            }
        }
    }

    func deleteUser(_ user: User) {
        db.collection("users").document(user.id).delete { error in
            if let error {
                print("Error deleting user: \(error)")
            }
        }
    }
    
    func getRoleColor(forRole role: String) -> (
        mainColor: Color,
        backgroundColor: Color
    ) {
        switch role {
            case Role.admin.rawValue:
                return (Color.adminRole, Color.adminRoleBackground)
            case Role.user.rawValue:
                return (Color.userRole, Color.userRoleBackground)
            default: // Taken by driver
                return (Color.driverRole, Color.driverRoleBackground)
        }
    }
    
}
