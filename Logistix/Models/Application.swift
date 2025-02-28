import Foundation

enum ApplicationStatus: String {
    case waitingForAnswer = "Ожидает ответа"
    case completed = "Выполнен"
}

struct Application: Codable, Identifiable, Hashable {
    let id: String
    let userID: String
    let name: String
    let email: String
    let company: String
    let phone: String
    let status: String
    let date: Date
}
