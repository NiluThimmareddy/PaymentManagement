//
//  invoiceDetailsHeaderView.swift
//  PaymentManagement
//
//  Created by praveenkumar on 24/04/25.
//

import UIKit
class invoiceDetailsHeaderView: UIView{
    @IBOutlet weak var backView: UIView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var headerViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var scrollContentView: UIView!
    @IBOutlet weak var stackView: UIStackView!
    
    weak var scrollDelegate: InvoiceScrollSyncDelegate?

       override func awakeFromNib() {
           super.awakeFromNib()
           scrollView.delegate = self
           headerViewHeightConstraint.constant = 40
       }
}
extension invoiceDetailsHeaderView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollDelegate?.didScroll(contentOffset: scrollView.contentOffset)
    }
}
