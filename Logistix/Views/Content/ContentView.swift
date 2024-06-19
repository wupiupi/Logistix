//
//  ContentView.swift
//  Logistix
//
//  Created by Paul Makey on 11.05.24.
//

import SwiftUI
import RealmSwift

struct ContentView: View {
    @EnvironmentObject private var authVM: AuthViewModel
    
    var body: some View {
        Group {
            if authVM.currentUser != nil {
                MainView()
            } else {
                StartView()
            }
        }
    }
}

#Preview {
    ContentView()
}
