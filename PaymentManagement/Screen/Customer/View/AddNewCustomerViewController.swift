//
//  AddNewCustomerViewController.swift
//  PaymentManagement
//
//  Created by ToqSoft on 22/04/25.
//


import UIKit

class AddNewCustomerViewController: UIViewController, UITextFieldDelegate {

    // MARK: - IBOutlets
   
    @IBOutlet weak var AddCustomerscrollview: UIScrollView!
    @IBOutlet weak var companyNameTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var stateTextField: UITextField!
//    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var emailIDTextField: UITextField!
    @IBOutlet weak var contactPersoneNameTextField: UITextField!
    
    @IBOutlet weak var VATTextField: UITextField!
       @IBOutlet weak var GSTNameTextField: UITextField!
       @IBOutlet weak var TAXNameTextField: UITextField!

    @IBOutlet weak var companyNameValidationLabel: UILabel!
    @IBOutlet weak var addressValidationLabel: UILabel!
    @IBOutlet weak var stateValidationLabel: UILabel!
    @IBOutlet weak var countryValidationLabel: UILabel!
    @IBOutlet weak var phoneNumberValidationLabel: UILabel!
    @IBOutlet weak var emailIDValidationLabel: UILabel!
    @IBOutlet weak var contactPersonNameValidationLabel: UILabel!

    // MARK: - Properties
    var addCustomerVM = AddCustomerViewModel()

    var textFieldMap: [UITextField: (fieldType: CustomerFieldType, label: UILabel)] = [:]

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        mapFields()
        setupTextFieldObservers()
    }

    private func mapFields() {
        textFieldMap = [
            companyNameTextField: (.companyName, companyNameValidationLabel),
            addressTextField: (.address, addressValidationLabel),
            stateTextField: (.state, stateValidationLabel),
//            countryTextField: (.country, countryValidationLabel),
            phoneNumberTextField: (.phone, phoneNumberValidationLabel),
            emailIDTextField: (.email, emailIDValidationLabel),
            contactPersoneNameTextField: (.contactPersonName, contactPersonNameValidationLabel)
        ]

        // Hide all validation labels
        textFieldMap.values.forEach { $0.label.isHidden = true }

        // Reset border styles
        textFieldMap.keys.forEach {
            $0.layer.borderWidth = 0
            $0.layer.cornerRadius = 5
        }
    }

    private func setupTextFieldObservers() {
        textFieldMap.keys.forEach {
            $0.addTarget(self, action: #selector(textFieldDidEndEditing(_:)), for: .editingDidEnd)
        }
    }

//    @objc private func textFieldEditingChanged(_ textField: UITextField) {
//        validateField(textField)
//    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        validateField(textField)
    }

    private func validateField(_ textField: UITextField) {
        guard let text = textField.text,
              let info = textFieldMap[textField] else { return }

        if let error = addCustomerVM.validateField(info.fieldType, value: text) {
            applyValidationStyle(textField: textField, label: info.label, message: error)
        } else {
            clearValidationStyle(textField: textField, label: info.label)
        }
    }

    private func applyValidationStyle(textField: UITextField, label: UILabel, message: String) {
        label.text = message
        label.isHidden = false

        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.red.cgColor
        shake(textField)
    }

    private func clearValidationStyle(textField: UITextField, label: UILabel) {
        label.isHidden = true
        textField.layer.borderWidth = 0
    }

    private func shake(_ view: UIView) {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.05
        animation.repeatCount = 3
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: view.center.x - 5, y: view.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: view.center.x + 5, y: view.center.y))
        view.layer.add(animation, forKey: "position")
    }

    // MARK: - Submit Action
    @IBAction func submitButtonAction(_ sender: UIButton) {
        var allValid = true

        for (textField, info) in textFieldMap {
            let value = textField.text ?? ""
            if let error = addCustomerVM.validateField(info.fieldType, value: value) {
                applyValidationStyle(textField: textField, label: info.label, message: error)
                allValid = false
            } else {
                clearValidationStyle(textField: textField, label: info.label)
            }
        }

        if allValid {
            print("✅ All fields validated successfully. Submit to backend.")
            // Proceed with your save or API logic
        } else {
            print("❌ Validation failed.")
        }
    }
    
    
    @IBAction func closeButtonAction(_ sender: UIButton) {
        
        self.dismiss(animated: true)
    }
}
