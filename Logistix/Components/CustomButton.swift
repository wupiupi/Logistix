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
                    .padding(.trailing, 20)
            }
            .padding(.top, 15)
            .padding(.bottom, 10)
            .padding(.leading, 16)
            .foregroundStyle(.white)
            .background {
                Capsule()
                    .foregroundStyle(.mint)
            }
        }
        .frame(width: UIScreen.main.bounds.width - 32)
    }
}

#Preview {
    CustomButton(
        title: "Start",
        systemImage: "arrowshape.right.fill") {}
}
