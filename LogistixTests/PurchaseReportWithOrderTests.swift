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

  func testViewPurchaseReportWithOrder() {
   let purchaseReportService = PurchaseReportService()
   let userID = "user123"

     purchaseReportService.addPurchase(for: userID, purchase: Purchase(id: "order1", date: "2024-06-01", amount: 100.0))
     purchaseReportService.addPurchase(for: userID, purchase: Purchase(id: "order2", date: "2024-06-02", amount: 150.0))
    
     do {
       let report = try purchaseReportService.viewPurchaseReport(for: userID)
       XCTAssertEqual(report.count, 2)
     } catch {
       XCTFail("Отчет о покупках не должен выбрасывать ошибку при наличии покупок")
     }
   }
}
