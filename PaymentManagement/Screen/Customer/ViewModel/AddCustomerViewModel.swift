////
////  AddCustomerViewModel.swift
////  PaymentManagement
////
////  Created by ToqSoft on 28/04/25.
//
//import Foundation
//import Combine
//
//
//enum CustomerFieldType: String, CaseIterable {
//    case companyName, address, city, state, country, phone, email, contactPersonName
//}
//
//class AddCustomerViewModel {
//    
//    // Publishers for each text field
//    @Published var companyName: String = ""
//    @Published var address: String = ""
//    @Published var city: String = ""
//    @Published var state: String = ""
//    @Published var country: String = ""
//    @Published var phone: String = ""
//    @Published var email: String = ""
//    @Published var contactPersonName: String = ""
//    
//    // Validation publisher
//    @Published var isFormValid: Bool = false
//    
//    private var cancellables = Set<AnyCancellable>()
//    
//    init() {
//        setupValidation()
//    }
//    
//    private func setupValidation() {
//        Publishers.CombineLatest4(
//            Publishers.CombineLatest(companyNamePublisher, addressPublisher),
//            Publishers.CombineLatest(cityPublisher, statePublisher),
//            Publishers.CombineLatest(countryPublisher, phonePublisher),
//            Publishers.CombineLatest(emailPublisher, contactPersonNamePublisher)
//        )
//        .map { (group1, group2, group3, group4) in
//            return group1.0 && group1.1 &&
//                   group2.0 && group2.1 &&
//                   group3.0 && group3.1 &&
//                   group4.0 && group4.1
//        }
//        .assign(to: \.isFormValid, on: self)
//        .store(in: &cancellables)
//    }
//    
//    private var companyNamePublisher: AnyPublisher<Bool, Never> {
//        $companyName
//            .map { !$0.isEmpty }
//            .eraseToAnyPublisher()
//    }
//    
//    private var addressPublisher: AnyPublisher<Bool, Never> {
//        $address
//            .map { !$0.isEmpty }
//            .eraseToAnyPublisher()
//    }
//    
//    private var cityPublisher: AnyPublisher<Bool, Never> {
//        $city
//            .map { !$0.isEmpty }
//            .eraseToAnyPublisher()
//    }
//    
//    private var statePublisher: AnyPublisher<Bool, Never> {
//        $state
//            .map { !$0.isEmpty }
//            .eraseToAnyPublisher()
//    }
//    
//    private var countryPublisher: AnyPublisher<Bool, Never> {
//        $country
//            .map { !$0.isEmpty }
//            .eraseToAnyPublisher()
//    }
//    
//    private var phonePublisher: AnyPublisher<Bool, Never> {
//        $phone
//            .map { $0.count >= 8 }
//            .eraseToAnyPublisher()
//    }
//    
//    private var emailPublisher: AnyPublisher<Bool, Never> {
//        $email
//            .map { [weak self] email in
//                self?.isValidEmail(email) ?? false
//            }
//            .eraseToAnyPublisher()
//    }
//    
//    private var contactPersonNamePublisher: AnyPublisher<Bool, Never> {
//        $contactPersonName
//            .map { !$0.isEmpty }
//            .eraseToAnyPublisher()
//    }
//    
//    
//    private func isValidEmail(_ email: String) -> Bool {
//        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
//        return NSPredicate(format: "SELF MATCHES %@", emailRegEx).evaluate(with: email)
//    }
//    
//   
//        func validateField(_ type: CustomerFieldType, value: String?) -> String? {
//            guard let value = value, !value.isEmpty else {
//                return "\(type.rawValue.capitalized) is required"
//            }
//            
//            switch type {
//            case .email:
//                if !isValidEmail(value) {
//                    return "Please enter a valid email address."
//                }
//            case .phone:
//                if value.count < 8 {
//                    return "Phone number must be at least 8 digits."
//                }
//            default:
//                break
//            }
//            
//            return nil
//        }
//        
//      
//
//}


import Foundation

enum CustomerFieldType: String {
    case companyName, address, state, country, phone, email, contactPersonName
}

class AddCustomerViewModel {
    func validateField(_ type: CustomerFieldType, value: String) -> String? {
        switch type {
        case .companyName, .address, .state, .country, .contactPersonName:
            return value.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? "This field is required" : nil
        case .phone:
            return value.count < 10 ? "Enter a valid phone number" : nil
        case .email:
            return isValidEmail(value) ? nil : "Enter a valid email address"
        }
    }

    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}
