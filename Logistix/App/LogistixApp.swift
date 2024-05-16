//
//  LogistixApp.swift
//  Logistix
//
//  Created by Paul Makey on 11.05.24.
//

import SwiftUI

@main
struct LogistixApp: App {
    @StateObject private var ordersVM = OrdersViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(ordersVM)
        }
    }
}

