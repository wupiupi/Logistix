//
//  LoginViewModel.swift
//  Logistix
//
//  Created by Serge Broski on 5/21/24.
//

import Foundation

final class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
}

// MARK: - AuthenticationFormProtocol
extension LoginViewModel: AuthenticationFormProtocol {
    var formIsValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 5
    }
}
