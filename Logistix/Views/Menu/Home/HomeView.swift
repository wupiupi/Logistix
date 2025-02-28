import SwiftUI

struct HomeView: View {
    @Binding var selectedTab: String
    
    // Hiding Tab Bar
    init(selectedTab: Binding<String>) {
        self._selectedTab = selectedTab
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        // Tab View with Tabs
        TabView(selection: $selectedTab) {
            
            // Views
            OrdersView()
                .tag("Заказы")
            
            NewOrderView()
                .tag("Новый заказ")
            
            OrdersHistoryView()
                .tag("История заказов")
            
            ContactUsView()
                .tag("Связаться с нами")
            
            ApplicationsView()
                .tag("Заявки")
            
            UsersView()
                .tag("Пользователи")
        }
    }
}
