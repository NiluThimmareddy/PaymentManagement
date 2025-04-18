//
//  CustomerModel.swift
//  PaymentManagement
//
//  Created by ToqSoft on 18/04/25.
//

import Foundation

struct Customer {
    var invoicenumber : String
    var transactionDate : String
    var amount : String
    var cardType : String
    var customerName : String
    
    init(invoicenumber: String, transactionDate: String, amount: String, cardType: String, customerName: String) {
        self.invoicenumber = invoicenumber
        self.transactionDate = transactionDate
        self.amount = amount
        self.cardType = cardType
        self.customerName = customerName
    }
}
