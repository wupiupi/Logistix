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

    func testCargoManagementActionsList() {

     let cargoManagementService = CargoManagementService()
     let actionsList = cargoManagementService.getActionsList()
      
     XCTAssertFalse(actionsList.isEmpty, "Список действий не должен быть пустым")
     XCTAssertTrue(actionsList.contains(.schedule), "Список действий должен содержать действие 'schedule'")
     XCTAssertTrue(actionsList.contains(.reschedule), "Список действий должен содержать действие 'reschedule'")
     XCTAssertTrue(actionsList.contains(.cancel), "Список действий должен содержать действие 'cancel'")
   }
}
