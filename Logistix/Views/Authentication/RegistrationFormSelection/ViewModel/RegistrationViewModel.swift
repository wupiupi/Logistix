//
//  RegistrationViewModel.swift
//  Logistix
//
//  Created by Serge Broski on 5/21/24.
//

import Foundation

final class RegistrationViewModel: ObservableObject {
    @Published var email = ""
    @Published var fullName = ""
    @Published var password = ""
    @Published var confirmPassword = ""
    @Published var auto = ""
}

// MARK: - AuthenticationFormProtocol
extension RegistrationViewModel: ValidationFormProtocol {
    var formIsValid: Bool {
        !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 5
        && confirmPassword == password
        && !fullName.isEmpty
    }
}
