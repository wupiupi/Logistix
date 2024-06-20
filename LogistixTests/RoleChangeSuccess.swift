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

    func testUserRoleChangeSuccess() {
     let userManagementService = UserManagementService()
     let userID = "user123"
      
     userManagementService.addUser(User(id: userID, name: "Иван Иванов", role: .user))
     do {
       try userManagementService.changeUserRole(userID: userID, newRole: .admin)
       let user = try userManagementService.getUser(userID: userID)
       XCTAssertEqual(user.role, .admin)
     } catch {
       XCTFail("Изменение роли пользователя не должно выбрасывать ошибку при корректном ID пользователя")
     }
   }
  }
