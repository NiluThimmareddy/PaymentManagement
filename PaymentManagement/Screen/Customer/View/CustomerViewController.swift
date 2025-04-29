//
//  CustomerViewController.swift
//  PaymentManagement
//
//  Created by ToqSoft on 18/04/25.
//

import UIKit

class CustomerViewController: UIViewController {
    
    
    @IBOutlet weak var customerScrollview: UIScrollView!
    @IBOutlet weak var customerTableView: UITableView!
    
    private let customerVM = CustomerViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addNewCustomer()
        fetchCustomerData()
        
        //        updateCustomer()
        //  deleteCustomer()
        setupAddCustomerButton()
        setupTableView()
        setScrollViewBorder()
    }
    
    func setScrollViewBorder(){
        customerScrollview.layer.borderWidth = 0.5
        customerScrollview.layer.borderColor = UIColor.placeholderText.cgColor
    }
    
    func setupAddCustomerButton(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(NavigateToaddNewCustomer))
        
    }
    
    @objc func NavigateToaddNewCustomer(){
        //Code For open Add Customer Form
        let storyboard = UIStoryboard(name: "Customer", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "AddNewCustomerViewController") as!
        AddNewCustomerViewController
        
        self.present(controller, animated: true)
    }
    
    func setupTableView(){
        customerTableView.delegate = self
        customerTableView.dataSource = self
        
        let nib = UINib(nibName: "CustomerTableViewCell", bundle: nil)
        customerTableView.register(nib, forCellReuseIdentifier: "CustomerTableViewCell")
    }
    
    func fetchCustomerData(){
        Task{
            customerVM.fetchCustomers { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let customer):
                        //                        self?.customerListLabel.text = customer.description
                        print(customer)
                        self?.customerTableView.reloadData()
                    case .failure(let error ) :
                        print("Error: \(error)")
                    }
                }
            }
        }
    }
    
    func addNewCustomer(){
        Task{
            customerVM.addCustomer(customerVM.newCustomer, completion: { [weak self] customerarray, error in
                if let error = error{
                    print("Failed to add: \(error)")
                }else if let customerarray = customerarray {
                    DispatchQueue.main.async {
                        self?.customerTableView.reloadData()
                    }
                    
                    print("Succcessfully added. Totla Count \(String(describing: customerarray.count)) \n \(customerarray)")
                }
            })
        }
    }
    
    
    func updateCustomer(){
        
        
        customerVM.updateCustomer(customerVM.updateCustomer, completion: { [weak self] customerarray, error in
            if let error = error{
                print("Failed to update: \(error)")
            }else if let list = customerarray{
                DispatchQueue.main.async {
                    self?.customerTableView.reloadData()
                }
                
                print("Succcessfully Customer updated :  \n \(list)")
            }
        })
        
    }
    
    
    func deleteCustomer(){
        
        
        customerVM.deleteCustomer(customerVM.CustomerToDelete) { [weak self] custoemrArray, error in
            if let error = error{
                print("Failed to delete Customer: \(error)")
            }else if let list = custoemrArray{
                DispatchQueue.main.async {
                    self?.customerTableView.reloadData()
                }
                
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
        let cell = customerTableView.dequeueReusableCell(withIdentifier: "CustomerTableViewCell") as! CustomerTableViewCell
        
        cell.setupData(customerData: customerVM.customers[indexPath.row])
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}
