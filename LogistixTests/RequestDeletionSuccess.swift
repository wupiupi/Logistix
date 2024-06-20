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

    func testRequestDeletionSuccess() {

     let requestDeletionService = RequestDeletionService()
     let requestID = "request123"
     requestDeletionService.addRequest(Request(id: requestID, status: .pending))
     do {
       try requestDeletionService.deleteRequest(requestID: requestID)
       XCTAssertThrowsError(try requestDeletionService.getRequest(requestID: requestID)) { error in
         XCTAssertEqual(error as? RequestDeletionError, RequestDeletionError.requestNotFound)
       }
     } catch {
       XCTFail("Удаление заявки не должно выбрасывать ошибку при корректном ID заявки")
     }
   }
}
