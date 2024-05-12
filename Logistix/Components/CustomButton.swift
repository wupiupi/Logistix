//
//  CustomButton.swift
//  Logistix
//
//  Created by Paul Makey on 12.05.24.
//

import SwiftUI

struct CustomButton: View {
    let title: String
    var systemImage: String = ""
    let onClick: () -> ()
    
    var body: some View {
        Button {
            onClick()
        } label: {
            HStack {
                Text(title)
                    .font(.title)
                    .fontWeight(.semibold)
                
                Spacer()
                                            
                Image(systemName: systemImage)
                    .imageScale(.small)
                    .font(.title)
                    .foregroundStyle(.white)
            }
            .padding(.top, 10)
            .padding(.bottom, 5)
            .padding([.leading, .trailing], 16)
            .foregroundStyle(.white)
        }
        .background {
            Capsule()
                .fill(Color(hex: 0x00CCA6, alpha: 1))
        }
    }
}

#Preview {
    CustomButton(
        title: "",
        systemImage: "") {
        }
}
