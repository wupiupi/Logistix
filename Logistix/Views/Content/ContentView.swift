//
//  ContentView.swift
//  Logistix
//
//  Created by Paul Makey on 11.05.24.
//

import SwiftUI
import RealmSwift

struct ContentView: View {
    @EnvironmentObject private var viewModel: AuthViewModel
    
    var body: some View {
        Group {
            if viewModel.currentUser != nil {
                MainView()
            } else {
                StartView()
            }
        }
    }
}

//#Preview {
//    ContentView()
//}
