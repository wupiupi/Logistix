//
//  Extension + View.swift
//  Logistix
//
//  Created by Paul Makey on 12.05.24.
//

import SwiftUI

extension View {
    func hAlign(alignment: Alignment) -> some View {
        self.frame(maxWidth: .infinity, alignment: alignment)
    }
    
    func vAlign(alignment: Alignment) -> some View {
        self.frame(maxHeight: .infinity, alignment: alignment)
    }
}
