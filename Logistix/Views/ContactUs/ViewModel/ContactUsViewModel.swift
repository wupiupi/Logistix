import Foundation

final class ContactUsViewModel: ObservableObject {
    @Published var name = ""
    @Published var email = ""
    @Published var company = ""
    @Published var phone = ""
    @Published var isShowingAlert = false
}

extension ContactUsViewModel {
    var formIsValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !name.isEmpty
        && !company.isEmpty
        && !phone.isEmpty
    }
}
