
import XCTest
import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine
@testable import Logistix

final class AuthorizationTests: XCTestCase {
  func testOrderFormValidation() {

   let orderForm = OrderForm()
   orderForm.customerName = ""
   orderForm.pickupAddress = "ул. Пушкина, д. Колотушкина"
   orderForm.deliveryAddress = "ул. Лермонтова, д. 3"
   orderForm.cargoDescription = "Мебель"
   orderForm.weight = 150.0
   orderForm.date = "2024-06-06"

   do {
     try orderForm.submit()
     XCTFail("Форма должна выбрасывать ошибку при некорректном заполнении")
   } catch {
    CTAssertEqual(OrderFormError.invalidCustomerName)
   }
 }
}
