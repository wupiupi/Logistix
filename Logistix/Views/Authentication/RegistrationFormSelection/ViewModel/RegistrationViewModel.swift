import Foundation

final class RegistrationViewModel: ObservableObject {
    @Published var email = ""
    @Published var fullName = ""
    @Published var password = ""
    @Published var confirmPassword = ""
    @Published var autoBrand = ""
    @Published var autoMaxWeight = ""
    @Published var autoRegNumber = ""
}

// MARK: - AuthenticationFormProtocol
extension RegistrationViewModel: ValidationFormProtocol {
    var isEmailValid: Bool {
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$")
        return emailPredicate.evaluate(with: email)
    }

    var isPasswordValid: Bool {
        password.count > 5
    }

    var isConfirmPasswordValid: Bool {
        confirmPassword == password
    }

    var isFullNameValid: Bool {
        !fullName.isEmpty 
        && fullName.rangeOfCharacter(from: .decimalDigits) == nil
    }

    var formIsValid: Bool {
        isEmailValid 
        && isPasswordValid
        && isConfirmPasswordValid
        && isFullNameValid
    }

}
