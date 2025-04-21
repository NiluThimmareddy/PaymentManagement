//
//  invoiceModel.swift
//  PaymentManagement
//
//  Created by ToqSoft on 21/04/25.
//


struct invoiceHeader : Codable{
    var  partitionKey : String? = "InvoiceHeaders"
    var rowKey : String?
    var invoiceNumber : String?
    var customerId : String?
    var companyName : String?
    var invoiceDate : String?
    var dueDate : String?
    var paymentTerms : String?
    var subtotal : String?
    var tax : String?
    var grandtotal : String?
    
    init(partitionKey: String? = "InvoiceHeaders", rowKey: String?, invoiceNumber: String?, customerId: String?, companyName: String?, invoiceDate: String?, dueDate: String?, paymentTerms: String?, subtotal: String?, tax: String?, grandtotal: String?) {
        self.partitionKey = partitionKey
        self.rowKey = rowKey
        self.invoiceNumber = invoiceNumber
        self.customerId = customerId
        self.companyName = companyName
        self.invoiceDate = invoiceDate
        self.dueDate = dueDate
        self.paymentTerms = paymentTerms
        self.subtotal = subtotal
        self.tax = tax
        self.grandtotal = grandtotal
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.partitionKey = try container.decodeIfPresent(String.self, forKey: .partitionKey)
        self.rowKey = try container.decodeIfPresent(String.self, forKey: .rowKey)
        self.invoiceNumber = try container.decodeIfPresent(String.self, forKey: .invoiceNumber)
        self.customerId = try container.decodeIfPresent(String.self, forKey: .customerId)
        self.companyName = try container.decodeIfPresent(String.self, forKey: .companyName)
        self.invoiceDate = try container.decodeIfPresent(String.self, forKey: .invoiceDate)
        self.dueDate = try container.decodeIfPresent(String.self, forKey: .dueDate)
        self.paymentTerms = try container.decodeIfPresent(String.self, forKey: .paymentTerms)
        self.subtotal = try container.decodeIfPresent(String.self, forKey: .subtotal)
        self.tax = try container.decodeIfPresent(String.self, forKey: .tax)
        self.grandtotal = try container.decodeIfPresent(String.self, forKey: .grandtotal)
    }
}

struct invoiceItem : Codable{
    var partitionKey : String? = "InvoiceItems"
    var rowKey : String?
    var itemId : String?
    var invoiceNumber : String?
    var itemDetails : String?
    var itemDescription : String?
    var quantity : String?
    var price : String?
    var tax : String?
    var total : String?
    
    init(partitionKey: String? = "InvoiceItems", rowKey: String?, itemId: String?, invoiceNumber: String?, itemDetails: String?, itemDescription: String?, quantity: String?, price: String?, tax: String?, total: String?) {
        self.partitionKey = partitionKey
        self.rowKey = rowKey
        self.itemId = itemId
        self.invoiceNumber = invoiceNumber
        self.itemDetails = itemDetails
        self.itemDescription = itemDescription
        self.quantity = quantity
        self.price = price
        self.tax = tax
        self.total = total
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.partitionKey = try container.decodeIfPresent(String.self, forKey: .partitionKey)
        self.rowKey = try container.decodeIfPresent(String.self, forKey: .rowKey)
        self.itemId = try container.decodeIfPresent(String.self, forKey: .itemId)
        self.invoiceNumber = try container.decodeIfPresent(String.self, forKey: .invoiceNumber)
        self.itemDetails = try container.decodeIfPresent(String.self, forKey: .itemDetails)
        self.itemDescription = try container.decodeIfPresent(String.self, forKey: .itemDescription)
        self.quantity = try container.decodeIfPresent(String.self, forKey: .quantity)
        self.price = try container.decodeIfPresent(String.self, forKey: .price)
        self.tax = try container.decodeIfPresent(String.self, forKey: .tax)
        self.total = try container.decodeIfPresent(String.self, forKey: .total)
    }
}
