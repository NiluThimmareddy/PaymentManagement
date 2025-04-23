//
//  AddNewCustomerViewController.swift
//  PaymentManagement
//
//  Created by ToqSoft on 22/04/25.
//

import UIKit

class AddNewCustomerViewController: UIViewController {

    @IBOutlet weak var AddCustomerscrollview: UIScrollView!
    @IBOutlet var ValidationLabelColletions: [UILabel]!
    
    @IBOutlet weak var companyNameTextField: UITextField!
    @IBOutlet weak var emailIDTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var stateTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var contactPersoneNameTextField: UITextField!
    @IBOutlet weak var VATTextField: UITextField!
    @IBOutlet weak var GSTNameTextField: UITextField!
    @IBOutlet weak var TAXNameTextField: UITextField!
    
    
    let customerVM = CustomerViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        AddCustomerscrollview.layer.borderWidth = 1
        AddCustomerscrollview.layer.borderColor = UIColor.placeholderText.cgColor
        
//        countryTextField.layer.borderWidth = 1
//        countryTextField.layer.borderColor = UIColor.placeholderText.cgColor
        
//        cityTextField.layer.borderWidth = 1
//        cityTextField.layer.borderColor = UIColor.placeholderText.cgColor
    }

   
   
    @IBAction func submitButtonAction(_ sender: UIButton) {
        guard let companyName = companyNameTextField.text, !companyName.isEmpty, let emailId = emailIDTextField.text, !emailId.isEmpty, let address =  addressTextField.text, !address.isEmpty, let country = countryTextField.text, !country.isEmpty else {
            
            for i in ValidationLabelColletions{
                i.isHidden = false
            }
            return
        }
        
    }
    

}
