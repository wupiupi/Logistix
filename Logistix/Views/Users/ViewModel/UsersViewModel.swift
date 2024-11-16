//
//  UsersViewModel.swift
//  Logistix
//
//  Created by Paul Makey on 28.05.24.
//

import SwiftUI
import FirebaseFirestore

@MainActor
final class UsersViewModel: ObservableObject {
    @Published var users: [User] = []
    
    private let db = Firestore.firestore()
    
    init() {
        updateUsers()
    }
    
    func updateUsers() {
        Task {
            self.users = []
            await fetchUsers()
        }
    }
    
    func fetchUsers() async {
        let usersReference = db.collection("users")
        usersReference.addSnapshotListener { querySnapshot, error in
            
            guard let querySnapshot else {
                print("Error: \(String(describing: error))")
                return
            }
            
            self.users.removeAll() // Clear existing users before appending new ones
            
            for document in querySnapshot.documents {
                // Extract the auto data as a dictionary
                var auto: Auto? = nil
                if let autoData = document["auto"] as? [String: Any] {
                    auto = Auto(
                        brand: autoData["brand"] as? String ?? "",
                        maxWeightLimit: autoData["maxWeightLimit"] as? String ?? "",
                        regNumber: autoData["regNumber"] as? String ?? ""
                    )
                }
                
                let user = User(
                    id: document["id"] as? String ?? "",
                    auto: auto,
                    email: document["email"] as? String ?? "",
                    name: document["name"] as? String ?? "",
                    pass: document["pass"] as? String ?? "",
                    role: document["role"] as? String ?? "",
                    orders: document["orders"] as? [Order] ?? [],
                    applications: document["applications"] as? [Application] ?? []
                )
                print(user)
                self.users.append(user)
            }
        }
    }
    
    func updateUserRole(id: String, role: String) {
        let docRef = db.collection("users").document(id)
        docRef.updateData(["role": role]) { error in
            if let error {
                print("Error updating document: \(error)")
            }
            self.updateUsers()
        }
    }
    
    func deleteUser(_ user: User) {
        let db = Firestore.firestore()
        db.collection("users")
            .document(user.id)
            .delete { error in
                if let error {
                    print("Error deleting user: \(error)")
                    return
                }
                
                // Remove the deleted user from the users array
                self.updateUsers()
            }
    }
}
