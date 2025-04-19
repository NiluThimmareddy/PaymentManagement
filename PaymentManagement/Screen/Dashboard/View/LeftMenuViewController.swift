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
        
        let storyboard = UIStoryboard(name: "Customer", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "CustomerViewController") as? CustomerViewController ?? UIViewController()
        self.show(controller, sender: self)
    }
    
}
