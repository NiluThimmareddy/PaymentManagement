//
//  TaxViewController.swift
//  PaymentManagement
//
//  Created by praveenkumar on 28/04/25.
//

import UIKit
import CoreData

class TaxViewController: UIViewController {

    @IBOutlet weak var taxListTV: UITableView!
    @IBOutlet weak var addNewButton: UIButton!
    @IBOutlet weak var taxListBackView: UIView!
    @IBOutlet weak var taxLineView: UIView!
    @IBOutlet weak var taxlistLbl: UILabel!
    
    var taxViewModel = TaxViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        taxViewModel.fetchTaxes()
        taxListTV.register(UINib(nibName: "TaxListTVC", bundle: nil), forCellReuseIdentifier: "TaxListTVC")
        
    }
    
    @IBAction func addNewButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Tax", bundle: nil)
        let controller = storyboard.instantiateViewController(identifier: "AddNewTaxViewController")as! AddNewTaxViewController
        self.present(controller, animated: true)
    }
    
    
}

extension TaxViewController: UITableViewDelegate, UITableViewDataSource,TaxListTVCDelegate{
    func didTapDeleteButton(forTax tax: TaxModel, at indexPath: IndexPath) {
        if let taxToDelete = CoreDataManager.shared.fetchTaxes().first(where: { $0.taxName == tax.name }) {
            CoreDataManager.shared.deleteTax(tax: taxToDelete)
            taxViewModel.taxes.remove(at: indexPath.row)
            taxListTV.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func didTapEditButton(forTax tax: TaxModel, at indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Tax", bundle: nil)
        let controller = storyboard.instantiateViewController(identifier: "UpdateTaxViewController") as! UpdateTaxViewController
        controller.taxToEdit = tax
        controller.indexPath = indexPath
        self.present(controller, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taxViewModel.taxes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaxListTVC", for: indexPath) as! TaxListTVC
        let tax = taxViewModel.taxes[indexPath.row]
        cell.configureCell(with: tax, indexPath: indexPath)
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let headerView = Bundle.main.loadNibNamed("TaxHeaderView", owner: self, options: nil)?.first as? TaxHeaderView {
            return headerView
        }
        
        return nil
        
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 50
        
    }
    
}
