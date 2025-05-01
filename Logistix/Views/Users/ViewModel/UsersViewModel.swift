import SwiftUI
import FirebaseFirestore

@MainActor
final class UsersViewModel: ObservableObject {
    
    enum UsersSortOrder: String, CaseIterable {
        case byRole = "По роли"
        case byOrdersCount = "По кол-ву созданных заказов"
        case byEmail = "По адресу эл.почты"
    }
    
    enum UsersSortOption: String, CaseIterable {
        case byRole = "По роли"
        case byEmail = "По email"
        case byName = "По имени"
    }
    
    @Published var searchTerm = ""
    @Published private(set) var users: [User] = []
    
    @Published var isSortSheetPresented = false
    @Published var selectedSortOption: UsersSortOption = .byEmail

    private let db = Firestore.firestore()
    private var listener: ListenerRegistration?

    init() {
        setupListener()
    }

    deinit {
        listener?.remove()  // Отключаем listener при удалении
    }
    
    var filteredUsers: [User] {
        let filtered = searchTerm.isEmpty
        ? users
        : users.filter { $0.email.localizedCaseInsensitiveContains(searchTerm) }
        
        switch selectedSortOption {
            case .byRole:
                return filtered.sorted {
                    let first = rolePriority[$0.role] ?? Int.max
                    let second = rolePriority[$1.role] ?? Int.max
                    return first < second
                }
            case .byEmail:
                return filtered.sorted { $0.email.lowercased() < $1.email.lowercased() }
            case .byName:
                return filtered.sorted { $0.name.lowercased() < $1.name.lowercased() }
        }
    }
    
    let rolePriority: [String: Int] = [
        Role.user.rawValue: 0,
        Role.driver.rawValue: 1,
        Role.admin.rawValue: 2
    ]
    
    let typePriority: [String: Int] = [
        "Отменен": 0,
        "На модерации": 1,
        "Ищем водителя": 2,
        "В работе": 3,
        "Завершен": 4
    ]

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
                    role: doc["role"] as? String ?? "", 
                    profilePhotoID: doc["profilePhotoID"] as? String ?? "",
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
