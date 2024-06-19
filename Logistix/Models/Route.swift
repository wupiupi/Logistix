//
//  Route.swift
//  Logistix
//
//  Created by Serge Broski on 5/18/24.
//

import Foundation
import RealmSwift

final class Route: Object, Codable {
    @Persisted var sourceAddress = ""
    @Persisted var destinationAddress = ""
}
