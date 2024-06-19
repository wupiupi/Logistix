//
//  Recipient.swift
//  Logistix
//
//  Created by Serge Broski on 5/18/24.
//

import Foundation
import RealmSwift

final class Recipient: Object, Codable {
    @Persisted var name = ""
    @Persisted var phoneNumber = ""
}
