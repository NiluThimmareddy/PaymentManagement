//
//  TaxListTVC.swift
//  PaymentManagement
//
//  Created by praveenkumar on 28/04/25.
//

import UIKit
protocol TaxListTVCDelegate: AnyObject {
    func didTapDeleteButton(forTax tax: TaxModel, at indexPath: IndexPath)
    func didTapEditButton(forTax tax: TaxModel, at indexPath: IndexPath)
}
class TaxListTVC: UITableViewCell {
    weak var delegate: TaxListTVCDelegate?
    var indexPath: IndexPath!
    var taxModel: TaxModel!
    @IBOutlet weak var percentageView: UIView!
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var buttonStackView: UIStackView!
    @IBOutlet weak var buttonView: UIView!
    @IBOutlet weak var topStackView: UIStackView!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var taxPercentageLbl: UILabel!
    @IBOutlet weak var taxNameLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        backView.applyCardStyle()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func editButton(_ sender: Any) {
        delegate?.didTapEditButton(forTax: taxModel, at: indexPath)
    }
    @IBAction func deleteButton(_ sender: Any) {
        delegate?.didTapDeleteButton(forTax: taxModel, at: indexPath)
    }
    func configureCell(with tax: TaxModel, indexPath: IndexPath) {
        self.taxModel = tax
        self.indexPath = indexPath
        taxPercentageLbl.text = "\(tax.percentage)%"
        taxNameLbl.text = tax.name
    }
}
