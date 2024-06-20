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

    func testUserBlockingSuccess() {

     let userManagementService = UserManagementService()
     let userID = "user123"
     userManagementService.addUser(User(id: userID, name: "Иван Иванов"))
     do {
       try userManagementService.blockUser(userID: userID)
       let user = try userManagementService.getUser(userID: userID)
       XCTAssertTrue(user.isBlocked)
     } catch {
       XCTFail("Блокировка пользователя не должна выбрасывать ошибку при корректном ID пользователя")
     }
 }
}
