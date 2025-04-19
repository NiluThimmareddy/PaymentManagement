//
//  CustomerViewModel.swift
//  PaymentManagement
//
//  Created by ToqSoft on 18/04/25.
//

import Foundation

class CustomerViewModel {
    private let genericViewModel =  GenericViewModel(service: JsonFileManager<Customer>(filename: Constant.JsonFileName.CustomeFileName, idMatcher: {$0.CustoemrId == $1.CustoemrId}))
    
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
