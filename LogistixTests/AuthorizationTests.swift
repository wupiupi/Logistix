//
//  AuthorizationTests.swift
//  LogistixTests
//
//  Created by Paul Makey on 2.06.24.
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
    
    func testFetchUser() async {
        // Arrange
        let expectedUser = User(
            id: "ErU3n3MraLS2kHYLvpq9eNG4WV72",
            role: "admin",
            email: "admin1@gmail.com",
            name: "Федор Иванович",
            pass: "8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92"
        )
        
        // Mock the Firestore document
        let mockDocument = Firestore.firestore().collection("users").document("abc123")
        try! mockDocument.setData(from: expectedUser)
        
        // Act
        await authViewModel.fetchUser()
        
        // Assert
        await MainActor.run {
            XCTAssertNotNil(authViewModel.currentUser)
            XCTAssertEqual(authViewModel.currentUser?.id, expectedUser.id)
            XCTAssertEqual(authViewModel.currentUser?.role, expectedUser.role)
            XCTAssertEqual(authViewModel.currentUser?.email, expectedUser.email)
            XCTAssertEqual(authViewModel.currentUser?.name, expectedUser.name)
            XCTAssertEqual(authViewModel.currentUser?.pass, expectedUser.pass)
        }
    }
    
    @MainActor func testSuccessfullPasswordHashing() {
        // Given (Arrange)
        let password = "123456"
        
        let authVM = AuthViewModel()
        
        // When (Act)
        let hashedPassword = authVM.hashPassword(password)
        
        // Then (Assert)
        XCTAssertEqual(hashedPassword, "8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92")
    }
}
