//
//  InvoiceDetailsTVC.swift
//  PaymentManagement
//
//  Created by toqsoft on 24/04/25.
//

import UIKit

class InvoiceDetailsTVC : UITableViewCell {
    
    @IBOutlet weak var itemDetailsTF: UITextField!
    @IBOutlet weak var descriptionTF: UITextField!
    @IBOutlet weak var qtyTF: UITextField!
    @IBOutlet weak var priceTF: UITextField!
    @IBOutlet weak var taxTF: UITextField!
    @IBOutlet weak var totalTF: UITextField!
    @IBOutlet weak var actionView: UIView!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    
    var didTapPlusButton: (() -> Void)?
    var didTapDeleteButton: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        [itemDetailsTF,descriptionTF,qtyTF,priceTF,taxTF,totalTF,actionView].forEach { border in
            border?.layer.borderWidth = 0.5
            border?.layer.borderColor = UIColor.lightGray.cgColor
        }
        
    }

    @IBAction func deleteButtonAction(_ sender: Any) {
        didTapDeleteButton?()
    }
    
    @IBAction func plusButtonAction(_ sender: Any) {
        didTapPlusButton?()
    }
    
    
}


