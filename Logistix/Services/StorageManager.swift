//
//  StorageManager.swift
//  Logistix
//
//  Created by Serge Broski on 5/14/24.
//

import Foundation
import RealmSwift

final class StorageManager {
    static let shared = StorageManager()
    
    private let realm: Realm
    
    private init() {
        do {
            realm = try Realm()
        } catch {
            fatalError("Failed to initialize Realm: \(error)")
        }
    }
    
    // MARK: - CRUD
    
    // Creating data
    func registerUser(
        withEmail email: String,
        andPass pass: String,
        andOrders orders: Order_,
        completion: (User) -> Void
    ) {
        write {
            let user = User(value: [email, pass])
            realm.add(user)
            completion(user)
        }
    }
    
    // Reading data
    func loginUser(email: String, password: String) -> User? {
        let user = realm.objects(User.self).filter("email = %@", email).first
        
        return user
    }
    
    
    // Updating data
    func fetchData<T>(_ type: T.Type) -> Results<T> where T: RealmFetchable {
        realm.objects(T.self)
    }
    
    // MARK: - Private Methods
    private func write(completion: () -> Void) {
        do {
            try realm.write {
                completion()
            }
        } catch {
            print(error)
        }
    }
}
