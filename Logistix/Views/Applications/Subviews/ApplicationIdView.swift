//
//  ApplicationIdView.swift
//  Logistix
//
//  Created by Serge Broski on 5/22/24.
//

import SwiftUI

struct ApplicationIdView: View {
    @EnvironmentObject private var applicationsVM: ApplicationsViewModel
    
    let application: ApplicationForm
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("№ \(application.id)")
                    .font(.title3)
                    .foregroundStyle(Color(hex: 0x00CCA6, alpha: 1))
                    .padding([.top, .bottom], 8)
                    .padding([.leading, .trailing], 8)
                    .background {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.main.opacity(0.2))
                    }
                
                Spacer()
                
                Text(applicationsVM.dateFormatter.string(from: application.date))
                    .font(.title3)
            }
        }
    }
}

#Preview {
    ApplicationIdView(application: ApplicationForm())
        .environmentObject(ApplicationsViewModel())
}
