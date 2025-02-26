import Foundation

final class MainViewModel: ObservableObject {
    @Published var selectedTab = "Заказы"
    @Published var showMenu = false
}
