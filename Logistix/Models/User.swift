//
//  User.swift
//  Logistix
//
//  Created by Serge Broski on 5/14/24.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

struct User: Codable, Identifiable {
    var id: String
    let role: DocumentReference?
    let email: String
    let name: String
    let pass: String
    let auto: String?
    
    var roleName: String?
}
