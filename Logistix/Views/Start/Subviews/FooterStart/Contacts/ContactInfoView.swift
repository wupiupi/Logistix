//
//  ContactInfoView.swift
//  Logistix
//
//  Created by Serge Broski on 5/21/24.
//

import SwiftUI

struct ContactInfoView: View {
    let image: String
    let text: String
    
    var body: some View {
        HStack {
            Image(image)
                .resizable()
                .foregroundStyle(.statusGreen)
                .frame(width: 22.81, height: 22.81)
            
            Text(text)
        }
    }
}
