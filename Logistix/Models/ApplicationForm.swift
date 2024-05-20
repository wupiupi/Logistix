//
//  ApplicationForm.swift
//  Logistix
//
//  Created by Serge Broski on 5/20/24.
//

import Foundation
import RealmSwift

final class ApplicationForm: Object, Codable, Identifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var userID = ""
    @Persisted var name = " "
    @Persisted var email = ""
    @Persisted var company = ""
    @Persisted var phone = ""
    @Persisted var status = "Без ответа"
    @Persisted var date = Date()
}
