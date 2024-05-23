//
//  MainViewModel.swift
//  Logistix
//
//  Created by Serge Broski on 5/21/24.
//

import Foundation

final class MainViewModel: ObservableObject {
    @Published var selectedTab = "Заказы"
    @Published var showMenu = false
}
