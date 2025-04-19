//
//  CustomerViewController.swift
//  PaymentManagement
//
//  Created by ToqSoft on 18/04/25.
//

import UIKit

class CustomerViewController: UIViewController {

    @IBOutlet weak var customerListLabel: UITextView!
    
    let CustomerTableView = UITableView()
    private let customerVM = CustomerViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchCustomerData()
       addNewCustomer()
//        updateCustomer()
      //  deleteCustomer()
    }
    
    func setupTableView(){
        CustomerTableView.delegate = self
        CustomerTableView.dataSource = self
        
    }
    
    func fetchCustomerData(){
        Task{
            customerVM.fetchCustomers { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let customer):
                        self?.customerListLabel.text = customer.description
                       // CustomerTableView.reloadData
                case .failure(let error ) :
                    print("Error: \(error)")
                }
            }
            }
        }
    }
    
    func addNewCustomer(){
        Task{
            let newCustomer = Customer(CustoemrId: "C006", CompanyName: "Testing", Address: "AddressTest", City: "Citytest", State: "StateTest", Country: "Cntry", PhoneNumebr: "rter", EmailAddress: "rtertr@gmail.com", ContactPerson: "dsd", Vat: 10, GST: 10, Tax: 2.5)
            
            customerVM.addCustomer( newCustomer, completion: { [weak self] customerarray, error in
                if let error = error{
                    print("Failed to add: \(error)")
                }else if let customerarray = customerarray {
                /*    DispatchQueue.main.async {
                          self?.CustomerTableView.reloadData()
                    }
                 */
                    
                    
                    print("Succcessfully added. Totla Count \(String(describing: customerarray.count)) \n \(customerarray)")
                }
            })
        }
    }
    
    
    func updateCustomer(){
            let updateCustomer = Customer(CustoemrId: "C005", CompanyName: "Testing", Address: "AddressTestupdate", City: "Citytest", State: "StateTest", Country: "Cntryupdate", PhoneNumebr: "rter", EmailAddress: "rtertr@gmail.com", ContactPerson: "dsd", Vat: 10, GST: 10, Tax: 2.5)
             
        customerVM.updateCustomer(updateCustomer, completion: { [weak self] customerarray, error in
                if let error = error{
                    print("Failed to update: \(error)")
                }else if let list = customerarray{
                    /*    DispatchQueue.main.async {
                              self?.CustomerTableView.reloadData()
                        }
                     */
                    print("Succcessfully Customer updated :  \n \(list)")
                }
            })
         
    }
    
    
    func deleteCustomer(){
            let CustomerToDelete = Customer(CustoemrId: "C006", CompanyName: "Testing", Address: "AddressTest", City: "Citytest", State: "StateTest", Country: "Cntry", PhoneNumebr: "rter", EmailAddress: "rtertr@gmail.com", ContactPerson: "dsd", Vat: 10, GST: 10, Tax: 2.5)
   
        customerVM.deleteCustomer(CustomerToDelete) { [weak self] custoemrArray, error in
                if let error = error{
                    print("Failed to delete Customer: \(error)")
                }else if let list = custoemrArray{
                    /*    DispatchQueue.main.async {
                              self?.CustomerTableView.reloadData()
                        }
                     */
                    print("Succcessfully Customer updeleteddated :  \n \(list)")
                }
            }
         
    }

    deinit {
        print("CustomerViewController deinitialized...")
    }
}

extension CustomerViewController : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.customerVM.customers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = CustomerTableView.dequeueReusableCell(withIdentifier: "cell")!
        return cell
        
    }
}
