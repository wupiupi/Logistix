//
//  AuthViewModel.swift
//  Logistix
//
//  Created by Paul Makey on 14.05.24.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import CryptoKit

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
    
    init() {
        userSession = Auth.auth().currentUser
        
        Task {
            await fetchUser()
        }
    }
    
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
            alertMessage = error.localizedDescription
        }
    }
    
    func createUser(
        withEmail email: String,
        password: String,
        fullName: String,
        phoneNumber: String?,
        role: Role,
        auto: String? = nil
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
                role: role.rawValue,
                email: email,
                name: fullName,
                pass: hashedPass,
                auto: auto
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
    
    func deleteAccount() {
        print("Deleting account...")
    }
    
    func fetchUser() async {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
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
    
    func hashPassword(_ password: String) -> String {
        let data = Data(password.utf8)
        let hash = SHA256.hash(data: data)
        return hash.compactMap { String(format: "%.02x", $0) }.joined()
    }
}
