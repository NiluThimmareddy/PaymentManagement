//
//  invoiceDetailsTVC.swift
//  PaymentManagement
//
//  Created by praveenkumar on 24/04/25.
//

import UIKit

class invoiceDetailsTVC: UITableViewCell {
    weak var scrollDelegate: InvoiceScrollSyncDelegate?
    @IBOutlet weak var contentViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var contentViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var totalAmountLbl: UILabel!
    @IBOutlet weak var taxLbl: UILabel!
    @IBOutlet weak var amountLbl: UILabel!
    @IBOutlet weak var quantityLbl: UILabel!
    @IBOutlet weak var itemDescLbl: UILabel!
    @IBOutlet weak var sNoLbl: UILabel!
    @IBOutlet weak var contentDataView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var backView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        scrollView.delegate = self
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.alwaysBounceHorizontal = false
        if UIDevice.current.userInterfaceIdiom == .pad {
            contentViewWidthConstraint.constant = 715
            scrollView.isScrollEnabled = false
        } else {
            contentViewWidthConstraint.constant = 600
        }
        contentViewHeightConstraint.constant = 40
    }
  

        override func prepareForReuse() {
            super.prepareForReuse()
            scrollView.delegate = self
        }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configureCell(sNo: Int, with invoice: invoiceItem) {
         let space = " "
        sNoLbl.text = "\(space)\(sNo)"
        itemDescLbl.text = "\(space)\(invoice.itemDescription ?? "No Description")"
        quantityLbl.text = "\(space)\(invoice.quantity ?? "0")"
        amountLbl.text = "\(space)\(invoice.price ?? "0.0")"
        taxLbl.text = "\(space)\(invoice.tax ?? "0.0")"
        totalAmountLbl.text = "\(space)\(invoice.total ?? "0.0")"
    }
    

}
extension invoiceDetailsTVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollDelegate?.didScroll(contentOffset: scrollView.contentOffset)
    }
}
