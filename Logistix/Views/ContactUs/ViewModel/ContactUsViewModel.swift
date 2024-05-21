//
//  ContactUsViewModel.swift
//  Logistix
//
//  Created by Serge Broski on 5/21/24.
//

import Foundation

final class ContactUsViewModel: ObservableObject {
    @Published var name = ""
    @Published var email = ""
    @Published var company = ""
    @Published var phone = ""
    @Published var isShowingAlert = false
    
}
