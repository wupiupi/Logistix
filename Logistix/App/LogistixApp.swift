//
//  LogistixApp.swift
//  Logistix
//
//  Created by Paul Makey on 11.05.24.
//

import SwiftUI
import RealmSwift
import Firebase

let realmApp = RealmSwift.App(id: "application-0-tqodywz")

@main
struct LogistixApp: SwiftUI.App {
    @StateObject private var viewModel = AuthViewModel()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView(app: realmApp)
                .environmentObject(viewModel)
        }
    }
}

