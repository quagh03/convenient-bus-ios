//
//  DateTimePickerTextField.swift
//  Bus
//
//  Created by Nguyễn Hữu Hiếu on 13/03/2024.
//

import Foundation
import SwiftUI

struct DateTimePickerTextField: UIViewRepresentable{
    
    private let textField = UITextField()
    private let datePicker = UIDatePicker()
    private let helper = Helper()
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        return dateFormatter
    }()
    
    public var placeholder: String
    @Binding public var date: Date?
    
    func makeUIView(context: Context) -> UITextField {
        self.datePicker.datePickerMode = .date
        self.datePicker.preferredDatePickerStyle = .wheels
        self.datePicker.addTarget(self.helper, action: #selector(self.helper.dateValueChanged), for: .valueChanged)
        self.textField.placeholder = self.placeholder
        self.textField.inputView = self.datePicker
        
        // accessory
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let doneButton = UIBarButtonItem(title: "Xong", style: .plain, target: self.helper, action: #selector(self.helper.dontButtonAction))
        toolbar.setItems([flexibleSpace, doneButton], animated: true)
        self.textField.inputAccessoryView = toolbar
        
        self.helper.dateChanged = {
            self.date = self.datePicker.date
        }
        self.helper.doneButtonTapped = {
            if self.date == nil {
                self.date = self.datePicker.date
            }
            self.textField.resignFirstResponder()
        }
        return self.textField
    }
    
    func updateUIView(_ uiView: UITextField, context: Context) {
        if let selectedDate = self.date{
            uiView.text = self.dateFormatter.string(from: selectedDate)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    class Helper{
        public var dateChanged: (()->Void)?
        public var doneButtonTapped: (()->Void)?
        @objc func dateValueChanged(){
            self.dateChanged?()
        }
        @objc func dontButtonAction(){
            self.doneButtonTapped?()
        }
    }
    
    class Coordinator {
        
    }
    
}
