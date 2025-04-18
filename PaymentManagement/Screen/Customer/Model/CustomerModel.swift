//
//  CustomerModel.swift
//  PaymentManagement
//
//  Created by ToqSoft on 18/04/25.
//

import Foundation

struct Customer : Codable{
    var CustoemrId : String
    var CompanyName : String
    var Address : String
    var City : String
    var State : String
    var Country : String
    var PhoneNumebr : String
    var EmailAddress : String
    var ContactPerson : String
    var Vat  : Int
    var GST : Int
    var Tax : Double
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.CustoemrId = try container.decode(String.self, forKey: .CustoemrId)
        self.CompanyName = try container.decodeIfPresent(String.self, forKey: .CompanyName) ?? "No Company name"
        self.Address = try container.decodeIfPresent(String.self, forKey: .Address) ?? "No Address"
        self.City = try container.decodeIfPresent(String.self, forKey: .City) ?? "-"
        self.State = try container.decodeIfPresent(String.self, forKey: .State) ?? "-"
        self.Country = try container.decodeIfPresent(String.self, forKey: .Country) ?? "-"
        self.PhoneNumebr = try container.decodeIfPresent(String.self, forKey: .PhoneNumebr) ?? "-"
        self.EmailAddress = try container.decodeIfPresent(String.self, forKey: .EmailAddress) ?? "No EmailID"
        self.ContactPerson = try container.decodeIfPresent(String.self, forKey: .ContactPerson) ?? "-"
        self.Vat = try container.decodeIfPresent(Int.self, forKey: .Vat) ?? 0
        self.GST = try container.decodeIfPresent(Int.self, forKey: .GST) ?? 0
        self.Tax = try container.decodeIfPresent(Double.self, forKey: .Tax) ?? 0.0
    }
}
