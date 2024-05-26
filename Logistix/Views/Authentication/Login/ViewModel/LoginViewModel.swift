//
//  LoginViewModel.swift
//  Logistix
//
//  Created by Serge Broski on 5/21/24.
//

import Foundation
import CryptoKit

final class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    
    var hashedPassword: String {
        hashPassword(password)
    }
    
    func hashPassword(_ password: String) -> String {
        let data = Data(password.utf8)
        let hash = SHA256.hash(data: data)
        return hash.compactMap { String(format: "%.02x", $0) }.joined()
    }
}

// MARK: - AuthenticationFormProtocol
extension LoginViewModel: ValidationFormProtocol {
    var formIsValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 5
    }
}
