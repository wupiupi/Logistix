//
//  ContentView.swift
//  Logistix
//
//  Created by Paul Makey on 11.05.24.
//

import SwiftUI
import RealmSwift

struct ContentView: View {
    @ObservedObject var app: RealmSwift.App
    
    var body: some View {
        if let user = app.currentUser {
            MainView()
                .environment(\.partitionValue, user.id )
        } else {
            LoginView()
        }
    }
}

//#Preview {
//    ContentView()
//}
