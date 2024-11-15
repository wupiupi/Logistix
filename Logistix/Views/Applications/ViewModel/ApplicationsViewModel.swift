//
//  ApplicationsViewModel.swift
//  Logistix
//
//  Created by Serge Broski on 5/22/24.
//

import SwiftUI
import Firebase

@MainActor
final class ApplicationsViewModel: ObservableObject {
    @Published var searchTerm = ""
    @Published var isViewExpanded = false
    @Published var applications: [Application] = []
        
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter
    }()
    
    init() {
        updateApplications()
    }
    
    func updateApplications() {
        Task {
            self.applications = []
            await fetchApplications()
        }
    }
    
    func fetchApplications() async {
        let db = Firestore.firestore()
        let usersRef = db.collection("users")

        do {
            let snapshot = try await usersRef.getDocuments()
            
            for document in snapshot.documents {
                if let ordersData = document.data()["applications"] as? [[String: Any]] {
                    for orderData in ordersData {
                        if let order = try? Firestore.Decoder().decode(Application.self, from: orderData) {
                            self.applications.append(order)
                        }
                    }
                }
                print(applications)
            }
        } catch {
            print("Error fetching orders: \(error)")
        }
    }
    
    func updateApplicationStatus(forID applicationID: String, status: String) async {
        let db = Firestore.firestore()
        let usersRef = db.collection("users")
        
        do {
            let snapshot = try await usersRef.getDocuments()
            for document in snapshot.documents {
                var applicationsData = document.data()["applications"] as? [[String: Any]] ?? []
                var applicationIndex: Int?
                
                // Find the order index
                for (index, applicationData) in applicationsData.enumerated() {
                    if let id = applicationData["id"] as? String, id == applicationID {
                        applicationIndex = index
                        break
                    }
                }
                
                // Update the order if found
                if let index = applicationIndex {
                    applicationsData[index]["status"] = status
                    
                    // Update the document with modified orders array
                    try await usersRef.document(document.documentID).updateData([
                        "applications": applicationsData
                    ])
                }
            }
            updateApplications()
        } catch {
            print("Error updating order status: \(error)")
        }
    }
    
    func deleteApplication(withID applicationID: String) async {
        let db = Firestore.firestore()
        let usersRef = db.collection("users")
        
        do {
            let snapshot = try await usersRef.getDocuments()
            for document in snapshot.documents {
                var ordersData = document.data()["applications"] as? [[String: Any]] ?? []
                var orderIndex: Int?
                
                // Find the order index
                for (index, orderData) in ordersData.enumerated() {
                    if let id = orderData["id"] as? String, id == applicationID {
                        orderIndex = index
                        break
                    }
                }
                
                // Remove the order if found
                if let index = orderIndex {
                    ordersData.remove(at: index)

                    // Update the document with modified orders array
                    try await usersRef.document(document.documentID).updateData([
                        "applications": ordersData
                    ])
                }
            }
            updateApplications()
        } catch {
            print("Error deleting order: \(error)")
        }
    }
    
    func getStatusColor(forApplicationStatus status: String) -> (
        mainColor: Color,
        backgroundColor: Color
    ) {
        switch status {
            case ApplicationStatus.waitingForAnswer.rawValue:
                return (Color.statusOrange, Color.statusOrangeBackgound)
            default:
                return (Color.statusGreen, Color.statusGreenBackground)
        }
    }
}
