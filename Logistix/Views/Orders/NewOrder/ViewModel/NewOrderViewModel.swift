import Foundation
import UIKit
import PhotosUI
import SwiftUI

final class NewOrderViewModel: ObservableObject {
    // MARK: - Payment
    enum Payment: String, CaseIterable {
        case card = "Банковским переводом"
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
    @Published var totalCost = ""
    @Published var payment: Payment = .cache
    @Published var cargoType: CargoType = .perishable
    
    @Published var isAgreededPrivacy = false
    @Published var showAlert = false
    
    @Published var alertTitle = "Ошибка"
    @Published var alertMessage = "Пожалуйста, введите корректные данные"
    
    @Published var selectedImage: UIImage?
    @Published var selectedItem: PhotosPickerItem?
    @Published var imageData: Data?
    
    // MARK: - Computed properties
    var costIncludingFee: Double {
        let startCost = Double(totalCost) ?? 0
        let costWithFee = startCost + startCost * 0.02
        return (costWithFee * 100).rounded() / 100
    }
    
    var isAddressValid: (String) -> Bool = { address in
        !address.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    var isNameValid: (String) -> Bool = { name in
        let pattern = "^[a-zA-Zа-яА-Я\\s]+$"
        return !name.isEmpty && NSPredicate(format: "SELF MATCHES %@", pattern).evaluate(with: name)
    }
    
    var isPhoneValid: (String) -> Bool = { phone in
            let pattern = "^(\\+375\\d{9}|80\\d{9})$"
            return NSPredicate(format: "SELF MATCHES %@", pattern).evaluate(with: phone)
        }
    
    var isTotalCostValid: Bool {
        if let cost = Double(totalCost) {
            return cost > 5
        }
        return false
    }
    
    var isDateValid: Bool {
        if let loading = dateOfLoading, let delivery = dateOfDelivery {
            return loading <= delivery
        }
        return false
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
        
        UISegmentedControl.appearance().selectedSegmentTintColor = .picker
        UISegmentedControl.appearance().setTitleTextAttributes(
            [.foregroundColor: UIColor.white],
            for: .selected
        )
        UISegmentedControl.appearance().setTitleTextAttributes(
            [.foregroundColor: UIColor.backgroundGray],
            for: .normal
        )
    }
    
    func updateDateValidation() {
        if let loading = dateOfLoading, let delivery = dateOfDelivery, loading > delivery {
            dateOfDelivery = nil
        }
    }
}

// MARK: - AuthenticationFormProtocol
extension NewOrderViewModel: ValidationFormProtocol {
    var formIsValid: Bool {
        isAddressValid(sourceAddress)
        && isAddressValid(destinationAddress)
        && isNameValid(senderName)
        && isPhoneValid(senderPhoneNumber)
        && isNameValid(recipientName)
        && isPhoneValid(recipientPhoneNumber)
        && dateOfLoading != nil
        && dateOfDelivery != nil
        && isDateValid
        && isTotalCostValid
    }
}
