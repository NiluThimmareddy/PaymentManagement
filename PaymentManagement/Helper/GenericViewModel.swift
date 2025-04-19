//
//  GenericViewModel.swift
//  PaymentManagement
//
//  Created by ToqSoft on 18/04/25.
//

import Foundation

class GenericViewModel<Service: AsyncDataServiceProtocol>{
    
    private let service: Service
    private(set) var items: [Service.T] = []
    
    init(service: Service) {
        self.service = service
    }
    
    func fetchData(completion: @escaping (Result<[Service.T], Error>) -> Void){
        Task{
            do{
                let data = try await service.fetchData()
                self.items = data
                completion(.success(data))
            }catch{
                completion(.failure(error))
            }
        }
    }
    
    //Add new item and save it into JSON File
    func addData(newData: Service.T, completion: @escaping ([Service.T]?, Error?) -> Void) {
        Task {
            do {
                // Fetch existing data
                var data = try await service.fetchData()
               data.append(newData)
                
                
                
                // Save updated data
                let savedData =    try  await service.saveData(self.items)
                self.items = savedData
                // Call completion with updated items
                completion(savedData, nil)
            } catch {
                print("Error in add Customer: \(error.localizedDescription)")
                completion(nil, error)
            }
        }
    }
    
    func updateData(_ updatedItem: Service.T, completion: @escaping ([Service.T]?, Error?) -> Void) {
        Task{
            do{
                let updatedData = try await service.updateData(updatedItem)
                self.items = updatedData
                completion(updatedData,nil)
            }catch{
                print("Error in update Customer: \(error.localizedDescription)")
                completion(nil,error)
            }
        }
        
    }
    
    func deleteData(_ itemToDelete: Service.T, completion: @escaping ([Service.T]?, Error?) -> Void) {
        Task{
            do{
                let updatedData = try await service.deleteData(itemToDelete)
                self.items = updatedData
                completion(updatedData,nil)
            }catch{
                print("Error in deleting Customer: \(error.localizedDescription)")
                completion(nil,error)
            }
        }
    }
}


