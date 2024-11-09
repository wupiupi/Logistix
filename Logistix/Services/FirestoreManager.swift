//
//  FirestoreManager.swift
//  Logistix
//
//  Created by Paul Makey on 7.11.24.
//

import Foundation
import FirebaseFirestore

final class FirestoreManager {
    private let db = Firestore.firestore()
    static let shared = FirestoreManager()
    
    private init() {}
    
    
}
