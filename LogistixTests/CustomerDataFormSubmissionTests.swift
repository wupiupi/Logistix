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

    func testCustomerDataFormSubmission() {
     let customerDataForm = CustomerDataForm()
     customerDataForm.customerName = "Иван Иванов"
     customerDataForm.email = "ivan.ivanov@example.com"
     customerDataForm.phoneNumber = "+79991234567"
     customerDataForm.address = "ул. Пушкина, д. Колотушкина"
      
     do {
       try customerDataForm.submit()
       XCTAssertTrue(customerDataForm.isSubmitted)
       } catch {
         XCTFail("Форма не должна выбрасывать ошибку при корректном заполнении")
       }
 }
}
