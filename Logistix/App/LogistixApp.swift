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
    @StateObject private var contactUsVM = ContactUsViewModel()
    @StateObject private var mainVM = MainViewModel()
    @StateObject private var ordersVM = OrdersViewModel()
    @StateObject private var newOrderVM = NewOrderViewModel(selectedWeight: .belowOneHundred)
    @StateObject private var applicationsVM = ApplicationsViewModel()
    @StateObject private var usersVM = UsersViewModel()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(authVM)
                .environmentObject(loginVM)
                .environmentObject(registrationVM)
                .environmentObject(contactUsVM)
                .environmentObject(mainVM)
                .environmentObject(ordersVM)
                .environmentObject(newOrderVM)
                .environmentObject(applicationsVM)
                .environmentObject(usersVM)
        }
    }
}

