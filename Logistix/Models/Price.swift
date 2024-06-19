//
//  Price.swift
//  Logistix
//
//  Created by Serge Broski on 5/18/24.
//

import Foundation
import RealmSwift

final class Price: Object, Codable {
    @Persisted var cargoCost = ""
    @Persisted var payment = ""
    @Persisted var totalCost = ""
}
