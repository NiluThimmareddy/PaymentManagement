//
//  FileManager.swift
//  PaymentManagement
//
//  Created by ToqSoft on 18/04/25.
//

import Foundation
class JsonFileManager<T: Codable>: AsyncDataServiceProtocol {
    
    private let filename : String
    private let fileManager = FileManager.default
    private let idMatcher : (T,T) -> Bool
    
    
    init(filename: String, idMatcher: @escaping (T,T) -> Bool) {
        self.filename = filename
        self.idMatcher = idMatcher
    }
    
    
    private var fileURL : URL {
        let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentsDirectory.appendingPathComponent(filename)
    }
    
    
    func fetchData() async throws -> [T] {
        if !fileManager.fileExists(atPath: fileURL.path){
            
            if let bundleURL = Bundle.main.url(forResource: filename.replacingOccurrences(of: ".json", with: ""), withExtension: "json"){
                try fileManager.copyItem(at: bundleURL, to: fileURL)
            }else{
                throw NSError(domain: "JsonFileManager", code: 404, userInfo: [NSLocalizedDescriptionKey: "File not found in bundle"])
            }
            
        }
        
        let data = try Data(contentsOf: fileURL)
        let decoded = try JSONDecoder().decode([T].self, from: data)
         return decoded
    }
    
    
    //save data to json file and return saved data
    func saveData(_ items:[T]) async throws -> [T] {
            let encoded = try JSONEncoder().encode(items)
        try encoded.write(to: fileURL)
        print(fileURL.absoluteString)
        
        return try await fetchData()
        
    }
    
    //update item based on id return saved data
    func updateData(_ updatedItem: T) async throws -> [T] {
           var current = try await fetchData()
        if let index = current.firstIndex(where: { idMatcher($0,updatedItem) }) {
            current[index] = updatedItem
        }
         return try await saveData(current)
       }
    
        //delete item based on id return saved data
    func deleteData(_ itemToDelete: T) async throws -> [T] {
        var current = try await fetchData()
        current.removeAll (where: {idMatcher($0,itemToDelete) })
        return try await saveData(current)
    }

}
