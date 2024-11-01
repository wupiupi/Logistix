//
//  UsersViewModel.swift
//  Logistix
//
//  Created by Paul Makey on 28.05.24.
//

import Foundation
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
        usersReference.addSnapshotListener {
            querySnapshot,
            error in
            
            guard let querySnapshot else {
                print("Error: \(String(describing: error))")
                return
            }
            
            for document in querySnapshot.documents {
                //document is dictionary of one user
                let user = User(
                    id: document["id"] as? String ?? "",
                    role: document["role"] as? String ?? "",
                    email: document["email"] as? String ?? "",
                    name: document["name"] as? String ?? "",
                    pass: document["pass"] as? String ?? "",
                    auto: document["auto"] as? String ?? ""
                )
                self.users.append(user)
            }
        }
    }
    
    func updateUserRole(id: String, role: Role) {
        let docRef = db.collection("users").document(id)
        docRef.updateData(["role": role.rawValue]) { error in
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
