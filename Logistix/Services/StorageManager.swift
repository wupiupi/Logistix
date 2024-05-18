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
        
        if let realmURL = Realm.Configuration.defaultConfiguration.fileURL {
                    let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
                    let fileURL = documentDirectory?.appendingPathComponent(realmURL.lastPathComponent)
                    print("Realm file URL: \(fileURL?.path ?? "")")
                }
        
        do {
            realm = try Realm()
        } catch {
            fatalError("Failed to initialize Realm: \(error)")
        }
    }
    
    // MARK: - CRUD
    
    // update
    func fetchData<T: RealmFetchable>(_ type: T.Type) -> Results<T> {
        realm.objects(T.self)
    }
    
////     load initial data. we don't have properly works data manager for that
//    func save<T: Object>(_ object: [T]) {
//        write {
//            realm.add(object)
//        }
//    }
    
    // save new
    func save<T: Object>(_ object: T, completion: (T) -> Void) {
        write {
            realm.add(object)
            completion(object)
        }
    }
    
//    // delete
//    func delete<T: Object>(_ object: T) {
//        write {
//            realm.delete(object)
//        }
//    }
    
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
