//
//  LoginView.swift
//  Logistix
//
//  Created by Paul Makey on 14.05.24.
//

import SwiftUI

struct LoginView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 30) {
                Text("Привет 👋🏻")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                LoginFieldsView()
                
                LoginButtonView()
            }
        }
    }
}
