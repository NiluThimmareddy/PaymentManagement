//
//  TaxViewModel.swift
//  PaymentManagement
//
//  Created by praveenkumar on 28/04/25.
//

import Foundation
class TaxViewModel {
    var taxes: [TaxModel] = []
    
    func fetchTaxes() {
        let taxObjects = CoreDataManager.shared.fetchTaxes()
        self.taxes = taxObjects.map { TaxModel(name: $0.taxName ?? "", percentage: $0.taxPercentage ?? "") }
    }
}
