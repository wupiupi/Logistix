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
                .foregroundStyle(.main)
                .frame(width: 22.81, height: 22.81)
            
            Text(text)
        }
    }
}

#Preview {
    ContactInfoView(
        image: "phone",
        text: "+375(29)555-66-77"
    )
}
