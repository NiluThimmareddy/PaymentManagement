//
//  LeftMenuViewController.swift
//  PaymentManagement
//
//  Created by ToqSoft on 18/04/25.
//

import UIKit
struct MenuItem {
    let title: String
    let imageName: String
    let subItems: [MenuItem]?
    let navigation: NavigationClass?
}
enum NavigationClass {
    case DashboardViewController, InvoiceDetailsViewController, InvoiceViewController,CustomerViewController,TaxViewController,CreateInvoiceViewController,InvoicelistViewController
}
class LeftMenuViewController: UIViewController {
   
    var callLeftMenu: [MenuItem] = [
        MenuItem(title: "Dashboard", imageName: "airplay", subItems: nil, navigation: .DashboardViewController),
        MenuItem(title: "Customer", imageName: "user", subItems: nil, navigation: .CustomerViewController),
        MenuItem(title: "Tax", imageName: "percent", subItems: nil, navigation: .TaxViewController),
        MenuItem(
            title: "Invoice",
            imageName: "wallet",
            subItems: [
                MenuItem(title: "Create Invoice", imageName: "create_invoice_icon", subItems: nil, navigation: .CreateInvoiceViewController),
                MenuItem(title: "Invoice List", imageName: "invoice_list_icon", subItems: nil, navigation: .InvoicelistViewController)
            ], navigation: nil
        )
    ]
    var expandedIndexes: Set<Int> = []
    @IBOutlet weak var leftMenuTV: UITableView!
    @IBOutlet weak var tableViewBackView: UIView!
    @IBOutlet weak var exitLeftMenuButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.transform = CGAffineTransform(translationX: -self.view.frame.width, y: 0)
        leftMenuTV.register(UINib(nibName: "LeftMenuTVC", bundle: nil), forCellReuseIdentifier: "LeftMenuTVC")
    }
    
   
    @IBAction func exitLeftMenuButton(_ sender: Any) {
        UIView.animate(withDuration: 0.3, animations: {
            self.view.frame.origin.x = -self.view.frame.width
        }) { _ in
            self.willMove(toParent: nil)
            self.view.removeFromSuperview()
            self.removeFromParent()
            
            // ✅ Inform parent via Notification
            NotificationCenter.default.post(name: Notification.Name("LeftMenuDismissed"), object: nil)
        }
    }
    
}

extension LeftMenuViewController: UITableViewDelegate, UITableViewDataSource, LeftMenuTVCDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return callLeftMenu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeftMenuTVC")as! LeftMenuTVC
        let data = callLeftMenu[indexPath.row]
        let isExpanded = expandedIndexes.contains(indexPath.row)
        cell.config(with: data, expanded: isExpanded)
        cell.delegate = self
        if indexPath.row == 3{
            cell.arrowImage.image = UIImage(named: "dload")
            
            
        }else{
            cell.arrowImage.isHidden = true
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 3{
            return 130
            
        }else{
            return 50
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        if indexPath.row == 0{
            let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "DashboardViewController") as? DashboardViewController ?? UIViewController()
            controller.title = "Dashboard"
            controller.navigationItem.backBarButtonItem?.title = ""
            self.show(controller, sender: self)
        }else if indexPath.row == 1{
            let storyboard = UIStoryboard(name: "Customer", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "CustomerViewController") as? CustomerViewController ?? UIViewController()
            controller.title = "Customer Details"
            controller.navigationItem.backBarButtonItem?.title = ""
            self.show(controller, sender: self)
            
        }else if indexPath.row == 2{
            let storyboard = UIStoryboard(name: "Tax", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "TaxViewController") as? TaxViewController ?? UIViewController()
            controller.title = "Invoice Details"
            controller.navigationItem.backBarButtonItem?.title = ""
            self.show(controller, sender: self)
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UILabel()
        header.text = "    MENU"
        header.font = UIFont.boldSystemFont(ofSize: 20)
        header.textColor = .white
        header.backgroundColor = .main
        return header
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
   
    func didSelectMenuItem(_ index: IndexPath) {
        if index.row == 0{
            let storyboard = UIStoryboard(name: "Invoice", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "InvoiceViewController") as? InvoiceViewController ?? UIViewController()
            controller.title = "Invoice"
            controller.navigationItem.backBarButtonItem?.title = ""
            self.show(controller, sender: self)
        }else if index.row == 1{
            let storyboard = UIStoryboard(name: "Invoice", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "InvoicePaymentsVC") as? InvoicePaymentsVC ?? UIViewController()
            controller.title = "Invoice List"
            controller.navigationItem.backBarButtonItem?.title = ""
            self.show(controller, sender: self)
        }
    }
}


