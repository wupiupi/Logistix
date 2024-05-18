//
//  Sender.swift
//  Logistix
//
//  Created by Serge Broski on 5/18/24.
//

import Foundation
import RealmSwift

final class Sender: Object, Codable {
    @Persisted var senderName = ""
    @Persisted var senderPhoneNumber = ""
}
