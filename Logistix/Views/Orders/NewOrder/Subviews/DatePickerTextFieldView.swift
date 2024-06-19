//
//  DatePickerTextFieldView.swift
//  Logistix
//
//  Created by Serge Broski on 5/22/24.
//

import SwiftUI

/// - Connecting UIKit DatePicker to SwiftUI.
/// I'm using it Only to Conform to the App Design from Figma tho
struct DatePickerTextFieldView: UIViewRepresentable {
    private let textField = UITextField()
    private let datePicker = UIDatePicker()
    private let helper = Helper()
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter
    }()
    
    var placeholder: String
    @Binding var date: Date?
    
    func makeUIView(context: Context) -> UITextField {
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .inline
        datePicker.addTarget(
            helper,
            action: #selector(helper.dateValueChanged),
            for: .valueChanged
        )
        textField.placeholder = placeholder
        textField.inputView = datePicker
        
        /// - Accessory View
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let flexibleSpace = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil
        )
        
        let doneButton = UIBarButtonItem(
            title: "Done",
            style: .plain,
            target: helper,
            action: #selector(helper.doneButtonAction)
        )
        
        toolbar.setItems([flexibleSpace, doneButton], animated: true)
        textField.inputAccessoryView = toolbar
        
        helper.dateChanged = {
            date = datePicker.date
        }
        
        helper.doneButtonTapped = {
            if date == nil {
                date = datePicker.date
            }
            self.textField.resignFirstResponder()
        }
        
        return textField
    }
    
    func updateUIView(_ uiView: UITextField, context: Context) {
        if let selectedDate = date {
            uiView.text = dateFormatter.string(from: selectedDate)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    class Helper {
        var dateChanged: (() -> Void)?
        var doneButtonTapped: (() -> Void)?
        
        @objc func dateValueChanged() {
            dateChanged?()
        }
        
        @objc func doneButtonAction() {
            doneButtonTapped?()
        }
    }
}

#Preview {
    DatePickerTextFieldView(
        placeholder: "Placeholder",
        date: .constant(Date.now)
    )
}
