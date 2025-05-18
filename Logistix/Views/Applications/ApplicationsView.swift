import SwiftUI

struct ApplicationsView: View {
    @EnvironmentObject private var applicationsVM: ApplicationsViewModel
    @EnvironmentObject private var mainVM: MainViewModel
        
    @FocusState private var isSearchFocused: Bool
    
    private var filteredApplications: [Application] {
        guard !applicationsVM.searchTerm.isEmpty else { return applicationsVM.applications }
        return applicationsVM.applications.filter { $0.id.localizedCaseInsensitiveContains(applicationsVM.searchTerm) }
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    
                    ApplicationsTitle(
                        title: applicationsVM.applications.isEmpty
                        ? "Никто еще не оставил заявку"
                        : "Заявки"
                    )
                    
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
            prompt: "Поиск по № заявки"
        )
        .focused($isSearchFocused)
        .onChange(of: isSearchFocused) { _, focused in
            mainVM.shouldBeHidden = focused
        }
    }
}
