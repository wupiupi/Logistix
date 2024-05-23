//
//  ShowMenuButtonView.swift
//  Logistix
//
//  Created by Serge Broski on 5/21/24.
//

import SwiftUI

struct ShowMenuButtonView: View {
    @EnvironmentObject private var mainVM: MainViewModel
    
    var body: some View {
        Button {
            withAnimation(.spring()) {
                mainVM.showMenu.toggle()
            }
        } label: {
            // Animated Drawer Button
            VStack(spacing: 5) {
                Capsule()
                    .fill(mainVM.showMenu ? .white : .primary)
                    .frame(width: 30, height: 3)
                // Rotating
                    .rotationEffect(.init(
                        degrees: mainVM.showMenu ? -50 : 0
                    ))
                    .offset(
                        x: mainVM.showMenu ? 2 : 0,
                        y: mainVM.showMenu ? 9 : 0
                    )
                
                VStack(spacing: 5) {
                    Capsule()
                        .fill(mainVM.showMenu ? .white : .primary)
                        .frame(width: 30, height: 3)
                    // Moving Up when Clicked
                    Capsule()
                        .fill(mainVM.showMenu ? .white : .primary)
                        .frame(width: 30, height: 3)
                        .offset(y: mainVM.showMenu ? -8 : 0)
                }
                .rotationEffect(.init(degrees: mainVM.showMenu ? 50 : 0))
            }
        }
        .padding()
    }
}

#Preview {
    ShowMenuButtonView()
        .environmentObject(MainViewModel())
}
