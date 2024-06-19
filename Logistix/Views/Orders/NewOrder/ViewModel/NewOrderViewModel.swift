//
//  NewOrderViewModel.swift
//  Logistix
//
//  Created by Serge Broski on 5/22/24.
//

import Foundation
import UIKit

final class NewOrderViewModel: ObservableObject {
    // MARK: - Payment
    enum Payment: String, CaseIterable {
        case card = "Картой онлайн"
        case cache = "Наличными"
    }
    
    // MARK: - Weight
    enum Weight: String, CaseIterable {
        case belowOneHundred = "до 100 кг"
        case belowFourHundred = "до 400 кг"
        case overFourHundred = "свыше 400 кг"
    }
    
    // MARK: - CargoType
    enum CargoType: String, CaseIterable {
        case perishable = "Скоропортящийся груз"
        case dangerous = "Опасный груз"
        case fragile = "Хрупкий груз"
        case overSized = "Крупногабаритный груз"
        case fireHazard = "Пожароопасный груз"
        case expensive = "Ценный груз"
    }
    
    // MARK: - State Properties
    @Published var sourceAddress = ""
    @Published var destinationAddress = ""
    @Published var senderName = ""
    @Published var senderPhoneNumber = ""
    @Published var recipientName = ""
    @Published var recipientPhoneNumber = ""
    @Published var selectedWeight: Weight = .belowOneHundred
    @Published var dateOfLoading: Date?
    @Published var dateOfDelivery: Date?
    @Published var cargoCost = ""
    @Published var payment: Payment = .cache
    @Published var cargoType: CargoType = .perishable
    
    @Published var isAgreededPrivacy = false
    @Published var showAlert = false
    
    @Published var alertTitle = "Ошибка"
    @Published var alertMessage = "Пожалуйста, введите корректные данные"
    
    // MARK: - Computable Properties
    var totalCost: String {
        switch selectedWeight {
            case .belowOneHundred: "5.000"
            case .belowFourHundred: "7.500"
            case .overFourHundred: "10.000"
        }
    }
    
    // MARK: - Init
    init(
        sourceAddress: String = "",
        destinationAddress: String = "",
        senderName: String = "",
        senderPhoneNumber: String = "",
        recipientName: String = "",
        recipientPhoneNumber: String = "",
        selectedWeight: Weight
    ) {
        self.sourceAddress = sourceAddress
        self.destinationAddress = destinationAddress
        self.senderName = senderName
        self.senderPhoneNumber = senderPhoneNumber
        self.recipientName = recipientName
        self.recipientPhoneNumber = recipientPhoneNumber
        self.selectedWeight = selectedWeight
        
        UISegmentedControl.appearance().selectedSegmentTintColor = .main
        UISegmentedControl.appearance().setTitleTextAttributes(
            [.foregroundColor: UIColor.white],
            for: .selected
        )
        UISegmentedControl.appearance().setTitleTextAttributes(
            [.foregroundColor: UIColor.backgroundGray],
            for: .normal
        )
    }
}

// MARK: - AuthenticationFormProtocol
extension NewOrderViewModel: ValidationFormProtocol {
    var formIsValid: Bool {
        sourceAddress != "" 
        && destinationAddress != ""
        && senderName != ""
        && senderPhoneNumber != ""
        && recipientName != ""
        && recipientPhoneNumber != ""
        && dateOfLoading != nil
        && dateOfDelivery != nil
        && dateOfLoading ?? Date() <= dateOfDelivery ?? Date()
    }
}
