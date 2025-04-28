//
//  LeftMenuViewController.swift
//  PaymentManagement
//
//  Created by ToqSoft on 18/04/25.
//

import UIKit

class LeftMenuViewController: UIViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func CustomersListButtonAction(_ sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "Invoice", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "InvoiceViewController") as? InvoiceViewController ?? UIViewController()
        controller.title = "Customer List"
        controller.navigationItem.backBarButtonItem?.title = ""
        
        self.show(controller, sender: self)
    }
    
}
