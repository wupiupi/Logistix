//
//  ApplicationForm.swift
//  Logistix
//
//  Created by Serge Broski on 5/20/24.
//

import Foundation

struct ApplicationForm: Codable, Identifiable {
    let id: String
    let userID: String
    let name: String
    let email: String
    let company: String
    let phone: String
    let status: String
    let date: Date
}
