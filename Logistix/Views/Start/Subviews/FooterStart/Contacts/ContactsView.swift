//
//  ContactsView.swift
//  Logistix
//
//  Created by Serge Broski on 5/21/24.
//

import SwiftUI

struct ContactsView: View {
    var body: some View {
        Text("Контакты")
            .fontWeight(.bold)
        
        ContactInfoView(
            image: "phone",
            text: "+375(29)555-66-77"
        )
                
        ContactInfoView(
            image: "location",
            text: "г. Минск, ул. Петруся Бровки, д. 2"
        )
        
        ContactInfoView(
            image: "email",
            text: "info@logistix.by"
        )
        
        SocialsView()
    }
}

#Preview {
    ContactsView()
}
