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
  
  func testProductDataFormValidation() {
    
   let productDataForm = ProductDataForm()
   productDataForm.productName = ""
   productDataForm.productDescription = "Деревянный обеденный стол"
   productDataForm.productWeight = 20.0
   productDataForm.productDimensions = "120x60x75"
    
   do {
     try productDataForm.submit()
     XCTFail("Форма должна выбрасывать ошибку при некорректном заполнении")
   } catch {
     XCTAssertEqual(ProductDataFormError.invalidProductName)
   }
  }
}
