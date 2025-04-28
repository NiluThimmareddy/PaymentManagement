//
//  CoreDataManager.swift
//  PaymentManagement
//
//  Created by praveenkumar on 28/04/25.
//

import CoreData
import UIKit

class CoreDataManager {
    static let shared = CoreDataManager()
    private init() {}

    // Access the context from AppDelegate's persistent container
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    // Method to save a new tax to Core Data
    func saveTax(name: String, percentage: String) {
        let tax = Tax(context: context)
        tax.taxName = name
        tax.taxPercentage = percentage
        
        // Attempt to save the context
        saveContext()
    }

    // Method to fetch all taxes stored in Core Data
    func fetchTaxes() -> [Tax] {
        let fetchRequest: NSFetchRequest<Tax> = Tax.fetchRequest()
        
        do {
            let taxes = try context.fetch(fetchRequest)
            return taxes
        } catch {
            print("❌ Failed to fetch taxes: \(error)")
            return [] // Return an empty array in case of error
        }
    }
    
    // Method to delete a tax from Core Data
    func deleteTax(tax: Tax) {
        context.delete(tax)
        saveContext()
    }

    // Method to save the Core Data context if there are any changes
    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
                print("✅ Core Data context saved successfully!")
            } catch {
                print("❌ Failed to save Core Data context: \(error)")
            }
        }
    }
}
