//
//  UpdateTaxViewController.swift
//  PaymentManagement
//
//  Created by praveenkumar on 28/04/25.
//

import UIKit
import CoreData

class UpdateTaxViewController: UIViewController {
    
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var taxPercentageTF: UITextField!
    @IBOutlet weak var taxNameTF: UITextField!
    @IBOutlet weak var updateButton: UIButton!
    
    var taxToEdit: TaxModel?
    var delegate: TaxListTVCDelegate?
    var indexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        closeButton.alpha = 0.01
        
        if let tax = taxToEdit {
            taxNameTF.text = tax.name
            taxPercentageTF.text = tax.percentage
        }
    }
    
    @IBAction func closeButton(_ sender: Any) {
        dismiss(animated: true)
    }
    @IBAction func xMarkCloseButton(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
    @IBAction func updateButton(_ sender: Any) {
        guard let taxName = taxNameTF.text, !taxName.isEmpty else {
            showAlert(message: "Please enter a tax name.")
            return
        }
        
        guard let taxPercentageText = taxPercentageTF.text, !taxPercentageText.isEmpty else {
            showAlert(message: "Please enter a valid tax percentage.")
            return
        }
        
        // Ensure that we have a selected tax to update
        guard var selectedTax = taxToEdit else {
            showAlert(message: "No tax selected to update.")
            return
        }
        
        // Update the tax values
        selectedTax.name = taxName
        selectedTax.percentage = taxPercentageText // Store the percentage as a string
        
        // Update the Core Data object (find the corresponding Tax entity)
        let taxes = CoreDataManager.shared.fetchTaxes()
        
        if let index = indexPath?.row, index < taxes.count {
            let taxToUpdate = taxes[index]
            taxToUpdate.taxName = selectedTax.name
            taxToUpdate.taxPercentage = selectedTax.percentage
            CoreDataManager.shared.saveContext()
        }
        
        // Inform the delegate to update the table view
        if let indexPath = indexPath {
            delegate?.didTapEditButton(forTax: selectedTax, at: indexPath)
        }
        
        // Dismiss the view after updating
        dismiss(animated: true)
    }
    
    // Helper method to show an alert
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
