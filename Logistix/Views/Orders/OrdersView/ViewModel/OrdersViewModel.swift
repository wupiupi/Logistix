//
//  OrdersViewModel.swift
//  Logistix
//
//  Created by Paul Makey on 13.05.24.
//

import Foundation
import Firebase

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
    
    // TODO: - Можно использовать Set вместо флага в теории
    func fetchSpecifiedOrders(isUserDriver: Bool) async {
        let db = Firestore.firestore()
        let usersRef = db.collection("users")

        do {
            let snapshot = isUserDriver 
            ? try await usersRef.whereField("role", isEqualTo: Role.driver.rawValue).getDocuments()
            : try await usersRef.whereField("role", isNotEqualTo: Role.driver.rawValue).getDocuments()
            
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
    
    func updateOrders() {
        Task {
            self.orders = []
            await fetchSpecifiedOrders(isUserDriver: false)
        }
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

                    // Update the document with modified orders array
                    try await usersRef.document(document.documentID).updateData([
                        "orders": ordersData
                    ])
                }
            }
            updateOrders()
        } catch {
            print("Error deleting order: \(error)")
        }
    }
}
