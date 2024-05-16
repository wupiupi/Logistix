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
    
    // update
    func fetchData<T>(_ type: T.Type) -> Results<T> where T: RealmFetchable {
        realm.objects(T.self)
    }
    
    // load initial data
    func save(_ orders: [Order_]) {
        write {
            realm.add(orders)
        }
    }
    
    // save new
    func save(_ order: String, completion: (Order_) -> Void) {
        write {
            let order = Order_(value: [order])
            realm.add(order)
            completion(order)
        }
    }
    
    // delete
    func delete(_ order: Order_) {
        write {
            realm.delete(order)
        }
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
