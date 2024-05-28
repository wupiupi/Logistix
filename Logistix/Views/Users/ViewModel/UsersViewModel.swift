//
//  UsersViewModel.swift
//  Logistix
//
//  Created by Paul Makey on 28.05.24.
//

import Foundation
import FirebaseFirestore

final class UsersViewModel: ObservableObject {
    @Published var users: [User] = []
    
    init() {
        Task {
            await fetchUsers()
        }
    }
    
    func fetchUsers() async {
        
        let usersReference = Firestore.firestore().collection("users")
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
                    pass: document["pass"] as? String ?? ""
                )
                self.users.append(user)
            }
        }
        print(self.users)
    }
}
