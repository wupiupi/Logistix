//
//  LogistixApp.swift
//  Logistix
//
//  Created by Paul Makey on 11.05.24.
//

import SwiftUI
import Firebase

@main
struct LogistixApp: App {
    @StateObject private var viewModel = AuthViewModel()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}

