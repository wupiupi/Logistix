import SwiftUI

struct HomeView: View {
    @Binding var selectedTab: String
    
    var body: some View {
        // Tab View with Tabs
        VStack {
            switch selectedTab {
                case "Заказы":
                    OrdersView()
                case "Новый заказ":
                    NewOrderView()
                case "История заказов":
                    OrdersHistoryView()
                case "Связаться с нами":
                    ContactUsView()
                case "Заявки":
                    ApplicationsView()
                default:
                    UsersView()
            }
        }
    }
}
