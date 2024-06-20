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

    func testRequestCancellationSuccess() {
       let requestCancellationService = RequestCancellationService()
       let requestID = "request123"
      
       requestCancellationService.addRequest(Request(id: requestID, status: .pending))
      
       do {
         try requestCancellationService.cancelRequest(requestID: requestID)
         let request = try requestCancellationService.getRequest(requestID: requestID)
         XCTAssertEqual(request.status, .cancelled)
       } catch {
         XCTFail("Отмена заявки не должна выбрасывать ошибку при корректном ID заявки")
       }
   }
}
