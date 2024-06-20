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

    func testOrderTrackingSuccess() {
       let orderTrackingService = OrderTrackingService()
       let validOrderNumber = "123456789"
       do {
       let orderStatus = try orderTrackingService.trackOrder(orderNumber: validOrderNumber)
          XCTAssertNotNil(orderStatus)
       } catch {
         XCTFail("Отслеживание заказа не должно выбрасывать ошибку при корректном номере заказа")
       }
 }
}
