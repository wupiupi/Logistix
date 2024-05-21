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
    @StateObject private var authVM = AuthViewModel()
    @StateObject private var loginVM = LoginViewModel()
    @StateObject private var registrationVM = RegistrationViewModel()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(authVM)
                .environmentObject(loginVM)
                .environmentObject(registrationVM)
        }
    }
}

