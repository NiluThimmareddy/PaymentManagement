//
//  DashboardViewController.swift
//  PaymentManagement
//
//  Created by ToqSoft on 18/04/25.
//

import UIKit

class DashboardViewController: UIViewController {
    var menuVC: LeftMenuViewController?
    @IBOutlet weak var leftMenuButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(leftMenuWasDismissed), name: Notification.Name("LeftMenuDismissed"), object: nil)
        
    }
    
    @objc func leftMenuWasDismissed() {
        menuVC = nil
    }
    @IBAction func leftMenuButton(_ sender: UIButton) {
        if menuVC == nil {
            let storyBoard = UIStoryboard(name: "Dashboard", bundle: nil)
            menuVC = storyBoard.instantiateViewController(withIdentifier: "LeftMenuViewController") as? LeftMenuViewController
            
            if let menuVC = menuVC {
                self.addChild(menuVC)   // 1. Add child
                self.view.addSubview(menuVC.view)   // 2. Add subview
                menuVC.didMove(toParent: self)   // 3. VERY IMPORTANT: Inform system
                
                self.navigationController?.isNavigationBarHidden = false
                menuVC.view.layoutIfNeeded()
                menuVC.view.frame = CGRect(x: -UIScreen.main.bounds.size.width, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
                
                UIView.animate(withDuration: 0.3, animations: {
                    menuVC.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
                    sender.isEnabled = true
                }, completion: nil)
            }
        } else {
            print("Menu is already open.")
        }
        
    }
    
   

}


