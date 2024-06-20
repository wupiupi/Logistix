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

    func testRequestConfirmationSuccess() {

     let requestConfirmationService = RequestConfirmationService()
     let requestID = "request123"
      
     requestConfirmationService.addRequest(Request(id: requestID, status: .pending))
      
     do {
       try requestConfirmationService.confirmRequest(requestID)

       let request = try requestConfirmationService.getRequest(requestID: requestID)
       XCTAssertEqual(request.status, .confirmed)
     } catch {
       XCTFail("Подтверждение заявки не должно выбрасывать ошибку при корректном ID заявки")
     }
   }
}
