//
//  CustomerModel.swift
//  PaymentManagement
//
//  Created by ToqSoft on 18/04/25.
//

import Foundation

struct Customer : Codable{
    var partitionKey : String? = "Customers"
    var rowKey : String? = ""
    var custoemrId : String?
    var companyName : String?
    var address : String?
    var city : String?
    var state : String?
    var country : String?
    var phoneNumebr : String?
    var emailAddress : String?
    var contactPerson : String?
    var vat  : Int?
    var gst : Int?
    var tax : Double
    
    init(rowKey:String? = "",CustoemrId: String?, CompanyName: String?, Address: String?, City: String?, State: String?, Country: String?, PhoneNumebr: String?, EmailAddress: String?, ContactPerson: String?, Vat: Int?, GST: Int?, Tax: Double) {
        self.rowKey = rowKey
        self.custoemrId = CustoemrId
        self.companyName = CompanyName
        self.address = Address
        self.city = City
        self.state = State
        self.country = Country
        self.phoneNumebr = PhoneNumebr
        self.emailAddress = EmailAddress
        self.contactPerson = ContactPerson
        self.vat = Vat
        self.gst = GST
        self.tax = Tax
    }
    
    
//    init(from decoder: any Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.CustoemrId = try container.decode(String?.self, forKey: .CustoemrId)
//        self.CompanyName = try container.decodeIfPresent(String?.self, forKey: .CompanyName) ?? "No Company name"
//        self.Address = try container.decodeIfPresent(String?.self, forKey: .Address) ?? "No Address"
//        self.City = try container.decodeIfPresent(String?.self, forKey: .City) ?? "-"
//        self.State = try container.decodeIfPresent(String?.self, forKey: .State) ?? "-"
//        self.Country = try container.decodeIfPresent(String?.self, forKey: .Country) ?? "-"
//        self.PhoneNumebr = try container.decodeIfPresent(String?.self, forKey: .PhoneNumebr) ?? "-"
//        self.EmailAddress = try container.decodeIfPresent(String?.self, forKey: .EmailAddress) ?? "No EmailID"
//        self.ContactPerson = try container.decodeIfPresent(String?.self, forKey: .ContactPerson) ?? "-"
//        self.Vat = try container.decodeIfPresent(Int.self, forKey: .Vat) ?? 0
//        self.GST = try container.decodeIfPresent(Int.self, forKey: .GST) ?? 0
//        self.Tax = try container.decodeIfPresent(Double.self, forKey: .Tax) ?? 0.0
//    }
}
