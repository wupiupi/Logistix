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
        }
        .navigationBarBackButtonHidden(true)
        .searchable(
            text: $applicationsVM.searchTerm,
            prompt: "Поиск по документам или заказам"
        )
    }
}
