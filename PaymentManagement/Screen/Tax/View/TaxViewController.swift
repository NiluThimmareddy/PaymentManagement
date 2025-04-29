//
//  TaxViewController.swift
//  PaymentManagement
//
//  Created by praveenkumar on 28/04/25.
//

import UIKit
import CoreData

class TaxViewController: UIViewController{
   
    

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
        taxListBackView.applyCardStyle()
        addNewButton.applyCardStyle()
    }
    
    @IBAction func addNewButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Tax", bundle: nil)
        let controller = storyboard.instantiateViewController(identifier: "AddNewTaxViewController")as! AddNewTaxViewController
        controller.onTaxAdded = { [weak self] in
            self?.taxViewModel.fetchTaxes()
            self?.taxListTV.reloadData()
        }
        self.present(controller, animated: true)
    }
    
}

extension TaxViewController: UITableViewDelegate, UITableViewDataSource,TaxListTVCDelegate{
    func didTapDeleteButton(forTax tax: TaxModel, at indexPath: IndexPath) {
        if let taxToDelete = CoreDataManager.shared.fetchTaxes().first(where: { $0.taxName == tax.name }) {
                // Delete from Core Data
                CoreDataManager.shared.deleteTax(tax: taxToDelete)
                
                // Re-fetch updated data
                taxViewModel.taxes = CoreDataManager.shared.fetchTaxes().map {
                    TaxModel(name: $0.taxName ?? "", percentage: $0.taxPercentage ?? "")
                }
                
                // Safety check
                if taxViewModel.taxes.indices.contains(indexPath.row) {
                    taxListTV.beginUpdates()
                    taxListTV.deleteRows(at: [indexPath], with: .automatic)
                    taxListTV.endUpdates()
                } else {
                    taxListTV.reloadData() // fallback for last item
                }
            }
    }

    
    func didTapEditButton(forTax tax: TaxModel, at indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Tax", bundle: nil)
        let controller = storyboard.instantiateViewController(identifier: "UpdateTaxViewController") as! UpdateTaxViewController
        controller.taxToEdit = tax
        controller.indexPath = indexPath
        controller.onUpdateTax = { [weak self] in
            self?.taxViewModel.fetchTaxes()
            self?.taxListTV.reloadData()
        }
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
