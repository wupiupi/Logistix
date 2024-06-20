//
//  AuthorizationTests.swift
//  LogistixTests
//
//  Created by Kushner Artem on 2.06.24.
//

import XCTest
import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine
@testable import Logistix

final class AuthorizationTests: XCTestCase {
    private var authViewModel: AuthViewModel!
    
    @MainActor override func setUp() {
        super.setUp()
        authViewModel = AuthViewModel()
    }
    
    override func tearDown() {
        super.tearDown()
        authViewModel = nil
    }

    func testGetRegisteredUsers() {

     let userManagementService = UserManagementService()
     userManagementService.addUser(User(id: "user1", name: "Иван Иванов"))
     userManagementService.addUser(User(id: "user2", name: "Мария Петрова"))

     do {
       let users = try userManagementService.getRegisteredUsers()
       XCTAssertEqual(users.count, 2)
       XCTAssertTrue(users.contains { $0.id == "user1" && $0.name == "Иван Иванов" })
       XCTAssertTrue(users.contains { $0.id == "user2" && $0.name == "Мария Петрова" })
     } catch {
       XCTFail("Получение зарегистрированных пользователей не должно выбрасывать ошибку")
     }
    }
}
