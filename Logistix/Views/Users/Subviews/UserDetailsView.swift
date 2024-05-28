//
//  UserDetailsView.swift
//  Logistix
//
//  Created by Paul Makey on 28.05.24.
//

import SwiftUI

struct UserDetailsView: View {
    let title: String
    let userInfo: String
    
    var body: some View {
        Text(title)
            .font(.title3)
            .foregroundStyle(.gray)
        
        HStack {
            Text(userInfo)
                .font(.title3)
                .foregroundStyle(.black)
        }
    }
}
