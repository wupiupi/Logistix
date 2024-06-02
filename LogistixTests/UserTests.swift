//
//  UserTests.swift
//  LogistixTests
//
//  Created by Paul Makey on 2.06.24.
//

import XCTest
import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine
@testable import Logistix

final class UserTests: XCTestCase {
    private var viewModel: UsersViewModel!
    private var authViewModel: AuthViewModel!
    private var mockFirestore: Firestore!
    private var cancellables: Set<AnyCancellable> = []
    
    @MainActor override func setUp() {
        super.setUp()
        viewModel = UsersViewModel()
        authViewModel = AuthViewModel()
        
        let settings = FirestoreSettings()
        settings.cacheSettings = false as! any LocalCacheSettings & NSObjectProtocol
        mockFirestore = Firestore.firestore()
        mockFirestore.settings = settings
    }
    
    override func tearDown() {
        viewModel = nil
        cancellables.forEach { $0.cancel() }
        super.tearDown()
    }
    
    @MainActor func testDeleteUser() async {
        // Arrange
        let user = User(
            id: "abc123",
            role: "admin",
            email: "test@example.com",
            name: "John Doe",
            pass: "hashedPassword"
        )
        
        // Mock the Firestore document
        let mockDocument = mockFirestore.collection("users").document("abc123")
        try! mockDocument.setData(from: user)
        
        // Act
        viewModel.deleteUser(user)
        
        // Assert
        do {
            let documentSnapshot = try await mockDocument.getDocument()
        } catch {
            print(error)
        }
//        XCTAssertNil(documentSnapshot.data())
        XCTAssert(viewModel.users.isEmpty)
    }
    
    func testUpdateUserRole() async {
        // Arrange
        let userId = "ErU3n3MraLS2kHYLvpq9eNG4WV72"
        let newRole: Role = .admin
        
        // Act
        await viewModel.updateUserRole(id: userId, role: newRole)
        
        // Assert
        let updatedUsers = await viewModel.users
        XCTAssertFalse(updatedUsers.isEmpty, "Users should have been updated.")
        
        // Check if the user's role was updated correctly
        if let updatedUser = updatedUsers.first(where: { $0.id == userId }) {
            XCTAssertEqual(updatedUser.role, newRole.rawValue, "User role was not updated correctly.")
        } else {
            XCTFail("The updated user was not found in the users array.")
        }
    }
}
