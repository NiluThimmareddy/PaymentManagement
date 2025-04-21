//
//  CustomerTableViewCell.swift
//  PaymentManagement
//
//  Created by ToqSoft on 21/04/25.
//

import UIKit

class CustomerTableViewCell: UITableViewCell {
    
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var companyAddressLabel: UILabel!
    @IBOutlet weak var companyCityLabel: UILabel!
    @IBOutlet weak var companyStateLabel: UILabel!
    @IBOutlet weak var companyPhoneNumberLabel: UILabel!
    @IBOutlet weak var companyEmailIdLabel: UILabel!
    @IBOutlet weak var companyContactPersonLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupData(customerData:Customer){
        let data = customerData
        
        
        self.companyNameLabel.text = data.companyName
        self.companyAddressLabel.text = data.address
        self.companyCityLabel.text = data.city
        self.companyStateLabel.text = data.state
        self.companyPhoneNumberLabel.text = data.phoneNumebr
        self.companyEmailIdLabel.text = data.emailAddress
        self.companyContactPersonLabel.text = data.contactPerson
        
        
    }

}
