//
//  TrackDetailView.swift
//  Logistix
//
//  Created by Serge Broski on 5/22/24.
//

import SwiftUI

struct DetailView: View {
    let title: String
    let orderInfo: String
    var systemImageName: String? = nil
    
    var body: some View {
        Text(title)
            .font(.title3)
            .foregroundStyle(.gray)
        
        HStack {
            if let systemImageName {
                Link(destination: URL(string: "https://belpost.by/Otsleditotpravleniye")!) {
                    Image(systemName: systemImageName)
                }
                .onTapGesture {
                    UIPasteboard.general.string = orderInfo
                }
            }
            
            if title == "Стоимость" {
                Text("\(orderInfo) BYN")
                    .font(.title3)
                    .foregroundStyle(.black)
            } else {
                Text(orderInfo)
                    .font(.title3)
                    .foregroundStyle(.black)
            }
        }
    }
}

#Preview {
    DetailView(
        title: "Адрес отправителя",
        orderInfo: "ул. Легендарная, 18"
    )
}
