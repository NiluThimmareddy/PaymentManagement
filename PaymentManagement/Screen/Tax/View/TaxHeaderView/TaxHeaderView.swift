//
//  TaxHeaderView.swift
//  PaymentManagement
//
//  Created by praveenkumar on 28/04/25.
//

import UIKit
class TaxHeaderView: UIView{
    @IBOutlet weak var titleStackView: UIStackView!
    @IBOutlet weak var titleview: UIView!
    override func awakeFromNib() {
           super.awakeFromNib()
           titleview.applyCardStyle()
        titleStackView.applyCardStyle()
       }
}
