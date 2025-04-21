//
//  CustomerViewModel.swift
//  PaymentManagement
//
//  Created by ToqSoft on 18/04/25.
//

import Foundation

class CustomerViewModel {
    private let genericViewModel =  GenericViewModel(service: JsonFileManager<Customer>(filename: Constant.JsonFileName.CustomeFileName, idMatcher: {$0.custoemrId == $1.custoemrId}))
    
    let newCustomer = Customer(rowKey: nil, CustoemrId: "", CompanyName: "newComapny", Address: "", City: "6th main road", State: "Karnataka", Country: "India", PhoneNumebr: "123-345-678", EmailAddress: "test@gmail.com", ContactPerson: "2346756", Vat: 0, GST: 4, Tax: 4.5)
  
    let updateCustomer = Customer(rowKey: "71a55052-26f2-4e4a-a23e-27b3fa648ad7", CustoemrId: "71a55052-26f2-4e4a-a23e-27b3fa648ad7", CompanyName: "newComapny", Address: "", City: "6th main road", State: "Karnataka", Country: "India", PhoneNumebr: "123-345-678", EmailAddress: "test@gmail.com", ContactPerson: "2346756", Vat: 0, GST: 4, Tax: 4.5)
    
    let CustomerToDelete = Customer(rowKey: "71a55052-26f2-4e4a-a23e-27b3fa648ad7", CustoemrId: "71a55052-26f2-4e4a-a23e-27b3fa648ad7", CompanyName: "newComapny", Address: "", City: "6th main road", State: "Karnataka", Country: "India", PhoneNumebr: "123-345-678", EmailAddress: "test@gmail.com", ContactPerson: "2346756", Vat: 0, GST: 4, Tax: 0.0)
    
    var customers: [Customer] {
        return genericViewModel.items
    }
    
    func fetchCustomers(completion: @escaping (Result<[Customer],Error>) -> Void) {
        genericViewModel.fetchData(completion: completion)
    }
    
    func addCustomer(_ custoemer: Customer, completion: @escaping ([Customer]?,Error?) -> Void){
       
        genericViewModel.addData(newData: custoemer, completion: completion)
    }
    
    func updateCustomer(_ customer: Customer, completion: @escaping ([Customer]?, Error?) -> Void) {
        genericViewModel.updateData(customer, completion: completion)
    }
    
    func deleteCustomer(_ customer: Customer, completion: @escaping ([Customer]?, Error?) -> Void) {
        genericViewModel.deleteData(customer, completion: completion)
    }
    
    
}
