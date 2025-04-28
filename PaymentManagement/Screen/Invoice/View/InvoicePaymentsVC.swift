//
//  InvoicePaymentsVC.swift
//  PaymentManagement
//
//  Created by toqsoft on 28/04/25.
//

import UIKit

class InvoicePaymentsVC : UIViewController {

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

extension InvoicePaymentsVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InvoicePaymentsTVC") as! InvoicePaymentsTVC
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
