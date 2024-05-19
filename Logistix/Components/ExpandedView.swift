//
//  ExpandedView.swift
//  Logistix
//
//  Created by Paul Makey on 14.05.24.
//

import SwiftUI

struct ExpandedView: View {
    var id = UUID()
    @ViewBuilder var content: any View
    
    var body: some View {
        ZStack {
            AnyView(content)
        }
    }
}
