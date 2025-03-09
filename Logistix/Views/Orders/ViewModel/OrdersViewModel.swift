import SwiftUI
import Firebase
import RealmSwift

@MainActor
final class OrdersViewModel: ObservableObject {
    
    @Published var searchTerm = ""
    @Published var isViewExpanded = false
    @Published var orders: [Order] = []
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter
    }()
    
    init() {
        updateOrders()
    }
    
    func updateOrders() {
        Task {
            self.orders = []
            await fetchOrders()
        }
    }
    
    // MARK: - DONT CALL UPDATEORDERS() HERE. BEWARE OF RECURSION
    func fetchOrders() async {
        let db = Firestore.firestore()
        let usersRef = db.collection("users")
        
        do {
            // Order was duplicating. This is the fix
            let snapshot = try await usersRef.whereField(
                "role",
                isNotEqualTo: Role.driver.rawValue
            ).getDocuments()
            
            for document in snapshot.documents {
                if let ordersData = document.data()["orders"] as? [[String: Any]] {
                    for orderData in ordersData {
                        if let order = try? Firestore.Decoder().decode(Order.self, from: orderData) {
                            self.orders.append(order)
                        }
                    }
                }
            }
        } catch {
            print("Error fetching orders: \(error)")
        }
    }
    
    func fetchOrderFromRealm(imageID: String) -> UIImage? {
        let realm = try! Realm()
        let realmImage = realm.objects(RealmImage.self).filter("imageID == %@", imageID).first
        if let imageData = realmImage?.data, let uiImage = UIImage(data: imageData) {
            return uiImage
        }
        return nil
    }
    
    func fetchCompletedOrders(forDriverID driverID: String) async -> [Order] {
        let db = Firestore.firestore()
        let usersRef = db.collection("users")
        var userOrders: [Order] = []
        
        do {
            let document = try await usersRef.document(driverID).getDocument()
            
            if let ordersData = document.data()?["orders"] as? [[String: Any]] {
                for orderData in ordersData {
                    if let order = try? Firestore.Decoder().decode(Order.self, from: orderData) {
                        userOrders.append(order)
                    }
                }
            } else {
                print("No orders found for user with ID \(driverID)")
            }
        } catch {
            print("Error fetching orders for user: \(error)")
        }
        
        return userOrders
    }
    
    func updateOrderStatus(forOrderID orderID: String, status: String) async {
        let db = Firestore.firestore()
        let usersRef = db.collection("users")
        
        do {
            let snapshot = try await usersRef.getDocuments()
            for document in snapshot.documents {
                var ordersData = document.data()["orders"] as? [[String: Any]] ?? []
                var orderIndex: Int?
                
                // Find the order index
                for (index, orderData) in ordersData.enumerated() {
                    if let id = orderData["id"] as? String, id == orderID {
                        orderIndex = index
                        break
                    }
                }
                
                // Update the order if found
                if let index = orderIndex {
                    ordersData[index]["status"] = status
                    
                    // Update the document with modified orders array
                    try await usersRef.document(document.documentID).updateData([
                        "orders": ordersData
                    ])
                }
            }
            updateOrders()
        } catch {
            print("Error updating order status: \(error)")
        }
    }
    
    func assignDriverToOrder(forOrderID orderID: String, driverID: String) async {
        let db = Firestore.firestore()
        let usersRef = db.collection("users")
        
        do {
            let snapshot = try await usersRef.getDocuments()
            for document in snapshot.documents {
                var ordersData = document.data()["orders"] as? [[String: Any]] ?? []
                var orderIndex: Int?
                
                // Find the order index
                for (index, orderData) in ordersData.enumerated() {
                    if let id = orderData["id"] as? String, id == orderID {
                        orderIndex = index
                        break
                    }
                }
                
                // Assign the driver if the order is found
                if let index = orderIndex {
                    ordersData[index]["assignedDriverID"] = driverID
                    
                    // Update the document with modified orders array
                    try await usersRef.document(document.documentID).updateData([
                        "orders": ordersData
                    ])
                }
            }
        } catch {
            print("Error assigning driver to order: \(error)")
        }
        updateOrders()
    }
    
    func removeDriverFromOrder(forOrderID orderID: String) async {
        let db = Firestore.firestore()
        let usersRef = db.collection("users")
        
        do {
            let snapshot = try await usersRef.getDocuments()
            for document in snapshot.documents {
                var ordersData = document.data()["orders"] as? [[String: Any]] ?? []
                var orderIndex: Int?
                
                // Find the order index
                for (index, orderData) in ordersData.enumerated() {
                    if let id = orderData["id"] as? String, id == orderID {
                        orderIndex = index
                        break
                    }
                }
                
                // Assign the driver if the order is found
                if let index = orderIndex {
                    ordersData[index]["assignedDriverID"] = ""
                    
                    // Update the document with modified orders array
                    try await usersRef.document(document.documentID).updateData([
                        "orders": ordersData
                    ])
                }
            }
        } catch {
            print("Error assigning driver to order: \(error)")
        }
        updateOrders()
    }
    
    func deleteOrder(withID orderID: String) async {
        let db = Firestore.firestore()
        let usersRef = db.collection("users")
        
        do {
            let snapshot = try await usersRef.getDocuments()
            for document in snapshot.documents {
                var ordersData = document.data()["orders"] as? [[String: Any]] ?? []
                var orderIndex: Int?
                
                // Find the order index
                for (index, orderData) in ordersData.enumerated() {
                    if let id = orderData["id"] as? String, id == orderID {
                        orderIndex = index
                        break
                    }
                }
                
                // Remove the order if found
                if let index = orderIndex {
                    ordersData.remove(at: index)
                    
                    updateOrders()
                    
                    // Update the document with modified orders array
                    try await usersRef.document(document.documentID).updateData([
                        "orders": ordersData
                    ])
                }
            }
        } catch {
            print("Error deleting order: \(error)")
        }
    }
    
    func getStatusColor(forOrderStatus status: String) -> (
        mainColor: Color,
        backgroundColor: Color
    ) {
        switch status {
            case OrderStatus.onModeration.rawValue:
                return (Color.onModeration, Color.onModerationBackgound)
            case OrderStatus.searchingForDriver.rawValue:
                return (Color.searchingForDriver, Color.searchingForDriverBackground)
            case OrderStatus.cancelled.rawValue:
                return (Color.cancelled, Color.cancelledBackground)
            case OrderStatus.completed.rawValue:
                return (Color.completed, Color.completedBackground)
            default: // Taken by driver
                return (Color.inProcess, Color.inProcessBackground)
        }
    }
}
