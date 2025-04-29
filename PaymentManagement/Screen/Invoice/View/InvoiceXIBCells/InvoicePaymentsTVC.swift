//
//  InvoicePaymentsTVC.swift
//  PaymentManagement
//
//  Created by toqsoft on 25/04/25.
//

import UIKit
protocol InvoicePaymentsTVCDelegate: AnyObject{
    func didViewCell(indexPath: IndexPath)
}
class InvoicePaymentsTVC: UITableViewCell {
 weak var delegate: InvoicePaymentsTVCDelegate?
    var indexPath: IndexPath!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var invoiceNumberLabel: UILabel!
    @IBOutlet weak var transactionDateLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var cardLabel: UILabel!
    @IBOutlet weak var customerNameLabel: UILabel!
    @IBOutlet weak var eyeButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        [invoiceNumberLabel,transactionDateLabel,amountLabel,cardLabel,customerNameLabel,eyeButton].forEach { border in
            border?.layer.borderWidth = 0.5
            border?.layer.borderColor = UIColor.lightGray.cgColor
        }
    }

    @IBAction func eyeButtonAction(_ sender: Any) {
        delegate?.didViewCell(indexPath: indexPath)
    }
    
}
