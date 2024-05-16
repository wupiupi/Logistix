//
//  AuthenticationManager.swift
//  Logistix
//
//  Created by Serge Broski on 5/14/24.
//

import Foundation
import RealmSwift

final class AuthenticationManager: ObservableObject {
    @Published var email = ""
    @Published var pass = ""
    @Published var name = ""
    @Published var orders = List<Order_>()
    
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    var authIsEnabled: Bool {
        email.count > 5
        && pass.count > 5
    }
    
//    func anonymouslyLogin() {
//        isLoading = true
//        errorMessage = nil
//        
//        realmApp.login(credentials: .anonymous) { [weak self] result in
//            DispatchQueue.main.async {
//                switch result {
//                case .success(_):
//                    print("success anonymously logged in")
//                case .failure(let error):
//                    self?.errorMessage = "login failed with \(error)"
//                }
//                
//                self?.isLoading = false
//            }
//        }
//    }
//    
//    func signUp() {
//        let client = realmApp.emailPasswordAuth
//        
//        client.registerUser(email: email, password: pass) { [weak self] error in
//            if let error = error {
//                self?.errorMessage = "sign up error: \(error)"
//                self?.isLoading = false
//            } else {
//                self?.login()
//            }
//        }
//    }
//    
//    func login() {
//        isLoading = true
//        errorMessage = nil
//        
//        let credentials = Credentials.emailPassword(email: email, password: pass)
//        
//        realmApp.login(credentials: credentials) { [weak self] result in
//            DispatchQueue.main.async {
//                switch result {
//                case .success(let success):
//                    print("login success")
//                case .failure(let error):
//                    self?.errorMessage = "login failed with \(error)"
//                }
//                
//                self?.isLoading = false
//            }
//        }
//    }
//    
//    func logOut() {
//        realmApp.currentUser?.logOut(completion: { error in
//            if let error = error {
//                print("error logout: \(error)")
//            }
//        })
//    }
}
