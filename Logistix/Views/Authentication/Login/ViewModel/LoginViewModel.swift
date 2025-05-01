import Foundation
import CryptoKit

final class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    
    
}

// MARK: - AuthenticationFormProtocol
extension LoginViewModel: ValidationFormProtocol {
    var isEmailValid: Bool {
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$")
        return emailPredicate.evaluate(with: email)
    }
    
    var isPasswordValid: Bool {
        password.count > 5
    }
    
    var formIsValid: Bool {
        isEmailValid
        && isPasswordValid
    }
}
