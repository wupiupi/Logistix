//
//  ApplicationsView.swift
//  Logistix
//
//  Created by Serge Broski on 5/20/24.
//

import SwiftUI

struct ApplicationsView: View {
    @EnvironmentObject private var applicationsVM: ApplicationsViewModel
        
    private var filteredApplications: [Application] {
        guard !applicationsVM.searchTerm.isEmpty else { return applicationsVM.applications }
        return applicationsVM.applications.filter { $0.name.localizedCaseInsensitiveContains(applicationsVM.searchTerm) }
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    
                    ApplicationsTitle()
                    
                    if applicationsVM.applications.isEmpty {
                        Text("Заявок нет")
                    }
                    
                    ForEach(filteredApplications, id: \.self) { application in
                        
                        Divider()
                        
                        ApplicationIdView(application: application)
                        
                        ExpandableApplicationView(application: application)
                    }
                }
                .padding()
            }
            .navigationTitle("Logistix")
            .toolbarBackground(
                LinearGradient(
                    colors: [
                        Color(hex: 0x00CCA6, alpha: 1),
                        Color(hex: 0x29B197, alpha: 0.5)
                    ],
                    startPoint: .leading,
                    endPoint: .trailing
                ),
                for: .navigationBar
            )
        }
        .navigationBarBackButtonHidden(true)
        .searchable(
            text: $applicationsVM.searchTerm,
            prompt: "Поиск по документам или заказам"
        )
    }
}
