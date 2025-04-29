import Foundation

enum Role: String {
    case admin
    case driver
    case user
}

struct User: Codable, Identifiable {
    let id: String
    let auto: Auto?
    let email: String
    let name: String
    let role: String
    let profilePhotoID: String?
    var orders: [Order]
    var applications: [Application]
}
