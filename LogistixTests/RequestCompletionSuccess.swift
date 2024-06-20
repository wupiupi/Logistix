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

    func testRequestCompletionSuccess() {

     let requestCompletionService = RequestCompletionService()
     let requestID = "request123"
     requestCompletionService.addRequest(Request(id: requestID, status: .pending))
     do {
       try requestCompletionService.completeRequest(requestID: requestID)
       let request = try requestCompletionService.getRequest(requestID: requestID)
       XCTAssertEqual(request.status, .completed)
     } catch {
       XCTFail("Завершение заявки не должно выбрасывать ошибку при корректном ID заявки")
     }
   }
 }
