//
//  InvoicePaymentsVC.swift
//  PaymentManagement
//
//  Created by toqsoft on 28/04/25.
//

import UIKit
struct InvoiceLabels {
    var invoiceNumber: String
    var transactionDate: String
    var amount: String
    var card: String
    var customerName: String
}

class InvoicePaymentsVC : UIViewController {
    var callInvoiceLabels = [
        InvoiceLabels(invoiceNumber: "INV001", transactionDate: "2025-04-20", amount: "$150.00", card: "MasterCard", customerName: "Alice Smith"),
        InvoiceLabels(invoiceNumber: "INV002", transactionDate: "2025-04-21", amount: "$200.50", card: "Visa", customerName: "Bob Johnson"),
        InvoiceLabels(invoiceNumber: "INV003", transactionDate: "2025-04-22", amount: "$300.75", card: "American Express", customerName: "Charlie Lee"),
        InvoiceLabels(invoiceNumber: "INV004", transactionDate: "2025-04-23", amount: "$125.30", card: "Discover", customerName: "David Brown"),
        InvoiceLabels(invoiceNumber: "INV005", transactionDate: "2025-04-24", amount: "$175.60", card: "Visa", customerName: "Eve White")
    ]

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var transactionPeriodLabel: UILabel!
    @IBOutlet weak var filterButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var insideScrollView: UIView!
    @IBOutlet weak var paymentListTableview: UITableView!
    @IBOutlet weak var invoiceNumberLabel: UILabel!
    @IBOutlet weak var transactionLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var cardLabel: UILabel!
    @IBOutlet weak var customerNameLabel: UILabel!
    @IBOutlet weak var actionLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        paymentListTableview.register(UINib(nibName: "InvoicePaymentsTVC", bundle: nil), forCellReuseIdentifier: "InvoicePaymentsTVC")
        [topView,filterButton,invoiceNumberLabel,transactionLabel,amountLabel,cardLabel,customerNameLabel,actionLabel].forEach { border in
            border?.layer.borderWidth = 1
            border?.layer.borderColor = UIColor.lightGray.cgColor
        }
        
    }
    
    @IBAction func filterButton(_ sender: Any) {
    }
    
}

extension InvoicePaymentsVC : UITableViewDelegate, UITableViewDataSource,InvoicePaymentsTVCDelegate {
    func didViewCell(indexPath: IndexPath) {
        let  data = callInvoiceLabels[indexPath.row]
        let storyboard = UIStoryboard(name: "Invoice", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "InvoiceDetailsViewController") as! InvoiceDetailsViewController
        controller.passData = data
        controller.title = "Invoice"
        controller.navigationItem.backBarButtonItem?.title = ""
        self.show(controller, sender: self)
       
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return callInvoiceLabels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InvoicePaymentsTVC") as! InvoicePaymentsTVC
        let  data = callInvoiceLabels[indexPath.row]
        cell.amountLabel.text = data.amount
        cell.cardLabel.text = data.card
        cell.customerNameLabel.text = data.customerName
        cell.invoiceNumberLabel.text = data.invoiceNumber
        cell.transactionDateLabel.text = data.transactionDate
        cell.delegate = self
        cell.indexPath = indexPath
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
