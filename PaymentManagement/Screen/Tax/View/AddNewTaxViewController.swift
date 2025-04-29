//
//  AddNewTaxViewController.swift
//  PaymentManagement
//
//  Created by praveenkumar on 28/04/25.
//

import UIKit

class AddNewTaxViewController: UIViewController {
  
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var taxPercentageTF: UITextField!
    @IBOutlet weak var taxNameTF: UITextField!
    
    var onTaxAdded: (() -> Void)?

    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        backView.applyCardStyle()
        submitButton.applyCardStyle()
    }
    
    
    @IBAction func closeButton(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func submitButton(_ sender: Any) {
        guard let taxName = taxNameTF.text, !taxName.isEmpty else {
            showAlert(message: "Please enter a tax name.")
            return
        }
        
        guard let taxPercentageText = taxPercentageTF.text, !taxPercentageText.isEmpty, let taxPercentage = Double(taxPercentageText) else {
            showAlert(message: "Please enter a valid tax percentage.")
            return
        }

        
        // Save the tax in Core Data
        CoreDataManager.shared.saveTax(name: taxName, percentage: taxPercentageText)
        onTaxAdded?()
        // Dismiss the view controller after saving
        dismiss(animated: true)
    }
    @IBAction func xMarkCloseButton(_ sender: Any) {
        dismiss(animated: true)
    }
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
