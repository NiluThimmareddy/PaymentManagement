//
//  AsyncDataServiceProtocol.swift
//  PaymentManagement
//
//  Created by ToqSoft on 18/04/25.
//

import Foundation
protocol AsyncDataServiceProtocol {
    associatedtype Item : Codable
    typealias T = Item
    func fetchData() async throws -> [T]
//    func addData(data:Item) async throws -> [Item]
    func saveData(_ items:[Item]) async throws -> [T]
    func updateData(_ updatedItem: T) async throws -> [T]
    func deleteData(_ itemToDelete: T) async throws -> [T]
    
}
