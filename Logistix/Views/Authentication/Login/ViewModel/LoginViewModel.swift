import Foundation
import CryptoKit

final class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
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
