//
//  InvoiceViewController.swift
//  PaymentManagement
//
//  Created by ToqSoft on 18/04/25.
//

import UIKit

class InvoiceViewController : UIViewController, UIPopoverPresentationControllerDelegate {

    @IBOutlet weak var createInvoiceTitleLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var dotLineView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var streetLabel: UILabel!
    @IBOutlet weak var areaLabel: UILabel!
    @IBOutlet weak var distLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var invoiceNumberTF: UITextField!
    @IBOutlet weak var invoiceDateTF: UITextField!
    @IBOutlet weak var invoiceDateButton: UIButton!
    @IBOutlet weak var dueDateTF: UITextField!
    @IBOutlet weak var dueDateButton: UIButton!
    @IBOutlet weak var paymentTermsButton: UIButton!
    @IBOutlet weak var itemDetailsLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var qtyLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var taxLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var actionLabel: UILabel!
    @IBOutlet weak var itemDetailsTableView: UITableView!
    @IBOutlet weak var subTotalTF: UITextField!
    @IBOutlet weak var totalTaxTF: UITextField!
    @IBOutlet weak var grandTotalTF: UITextField!
    @IBOutlet weak var submitInvoiceButton: UIButton!
    @IBOutlet weak var tableScrollView: UIScrollView!
    @IBOutlet weak var scrollHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var mainViewHeightConstraint: NSLayoutConstraint!
    
    
    var invoiceItems: [invoiceItem] = []
    var customerVM = CustomerViewModel()
    var filteredCustomers: [Customer] = []
    var isSearching = false

    let customerTableView = UITableView()
    
    let invoiceDatePicker = UIDatePicker()
    let dueDatePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
    }
   
    
    @IBAction func invoiceDateButtonAction(_ sender: Any) {
        if UIDevice.current.userInterfaceIdiom == .pad {
            presentDatePickerPopover(for: invoiceDateTF, picker: invoiceDatePicker)
        } else {
            invoiceDateTF.becomeFirstResponder()
        }
    }
    
    @IBAction func dueDateButtonAction(_ sender: Any) {
        if UIDevice.current.userInterfaceIdiom == .pad {
            presentDatePickerPopover(for: dueDateTF, picker: dueDatePicker)
        } else {
            dueDateTF.becomeFirstResponder()
        }
    }
    
    @IBAction func paymentButtonAction(_ sender: UIAction) {
        self.paymentTermsButton.setTitle(sender.title, for: .normal)
    }

    @IBAction func submitButtonAction(_ sender: Any) {
        let storyboard = UIStoryboard.init(name: "Invoice", bundle: nil).instantiateViewController(withIdentifier: "InvoicePaymentsVC") as! InvoicePaymentsVC
        self.navigationController?.pushViewController(storyboard, animated: true)
    }
    
}

extension InvoiceViewController : UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return tableView == itemDetailsTableView ? 1 : 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == customerTableView {
            return filteredCustomers.count
        }
        return invoiceItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == customerTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CustomerCell", for: indexPath)
            let customer = filteredCustomers[indexPath.row]
            cell.textLabel?.text = customer.companyName
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "InvoiceDetailsTVC", for: indexPath) as! InvoiceDetailsTVC
            let item = invoiceItems[indexPath.row]
            cell.didTapPlusButton = { [weak self] in
                self?.handlePlusButtonTap()
            }
            cell.didTapDeleteButton = { [weak self] in
                self?.handleDeleteButtonTap(indexPath: indexPath)
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == customerTableView {
            let selectedCustomer = filteredCustomers[indexPath.row]
            searchBar.text = selectedCustomer.companyName
            customerTableView.isHidden = true
            view.endEditing(true)

            streetLabel.text = selectedCustomer.address
            areaLabel.text = selectedCustomer.city
            distLabel.text = selectedCustomer.state
            countryLabel.text = selectedCustomer.country

            createInvoiceTitleLabel.isHidden = false
            scrollView.isHidden = false
        }
    }
}

extension InvoiceViewController {
    func setUpUI() {
        itemDetailsTableView.register(UINib(nibName: "InvoiceDetailsTVC", bundle: nil), forCellReuseIdentifier: "InvoiceDetailsTVC")
        
        backView.layoutIfNeeded()
        
        [itemDetailsLabel,descriptionLabel,qtyLabel,priceLabel,taxLabel,totalLabel,actionLabel].forEach { border in
            border?.layer.borderWidth = 1
            border?.layer.borderColor = UIColor.gray.cgColor
        }
        paymentTermsButton.layer.borderWidth = 0.5
        paymentTermsButton.layer.borderColor = UIColor.lightGray.cgColor
        
        customerTableView.frame = CGRect(x: searchBar.frame.origin.x,
                                         y: searchBar.frame.maxY,
                                         width: view.frame.width - 32,
                                         height: 200)
        customerTableView.register(UITableViewCell.self, forCellReuseIdentifier: "CustomerCell")
        customerTableView.delegate = self
        customerTableView.dataSource = self
        customerTableView.isHidden = true
        view.addSubview(customerTableView)
        
        searchBar.delegate = self
        fetchCustomerData()
        updateTableAndScrollHeight()
        
        let defaultItem = invoiceItem (
            rowKey: UUID().uuidString,
            itemId: "",
            invoiceNumber: "",
            itemDetails: "",
            itemDescription: "",
            quantity: "",
            price: "",
            tax: "",
            total: ""
        )
        invoiceItems.append(defaultItem)
        
        createInvoiceTitleLabel.isHidden = true
        scrollView.isHidden = true
        
        setupDatePickers()
    }
    
    func handlePlusButtonTap() {
        let newItem = invoiceItem(rowKey: UUID().uuidString,itemId: "",invoiceNumber: "",itemDetails: "",itemDescription: "",quantity: "",price: "",tax: "",total: "")
        
        invoiceItems.append(newItem)
        print("After adding a new item: \(invoiceItems)")
        let indexPath = IndexPath(row: invoiceItems.count - 1, section: 0)
        itemDetailsTableView.insertRows(at: [indexPath], with: .automatic)
        itemDetailsTableView.reloadData()
        updateTableAndScrollHeight()
    }
    
    func handleDeleteButtonTap(indexPath: IndexPath) {
        guard invoiceItems.count > 1 else { return }
        invoiceItems.remove(at: indexPath.row)
        print("After deleting item: \(invoiceItems)")
        itemDetailsTableView.deleteRows(at: [indexPath], with: .automatic)
        itemDetailsTableView.reloadData()
        updateTableAndScrollHeight()
    }
    
    func updateTableAndScrollHeight() {
        let rowHeight: CGFloat = 50
        let itemCount = max(invoiceItems.count, 1)

        tableHeightConstraint.constant = CGFloat(itemCount) * rowHeight
        scrollHeightConstraint.constant = 40 + tableHeightConstraint.constant
        mainViewHeightConstraint.constant = scrollHeightConstraint.constant - 300

        view.layoutIfNeeded()
    }

    func fetchCustomerData() {
        Task{
            customerVM.fetchCustomers { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let customer):
                        print(customer)
                    case .failure(let error ) :
                        print("Error: \(error)")
                    }
                }
            }
        }
    }
    
    func setupDatePickers() {
        [invoiceDatePicker, dueDatePicker].forEach { picker in
            picker.datePickerMode = .date
            picker.preferredDatePickerStyle = .inline
            picker.locale = Locale(identifier: "en_US")
        }
        
        invoiceDateTF.inputView = invoiceDatePicker
        dueDateTF.inputView = dueDatePicker
        
        invoiceDateTF.inputAccessoryView = createToolbar(selector: #selector(doneInvoiceDate))
        dueDateTF.inputAccessoryView = createToolbar(selector: #selector(doneDueDate))
        
        invoiceDatePicker.addTarget(self, action: #selector(invoiceDateChanged), for: .valueChanged)
        dueDatePicker.addTarget(self, action: #selector(dueDateChanged), for: .valueChanged)
    }
    
    func createToolbar(selector: Selector) -> UIToolbar {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: selector)
        
        toolbar.setItems([flexible, doneButton], animated: false)
        return toolbar
    }
    
    @objc func invoiceDateChanged() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        invoiceDateTF.text = formatter.string(from: invoiceDatePicker.date)
    }
    
    @objc func dueDateChanged() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        dueDateTF.text = formatter.string(from: dueDatePicker.date)
    }
    
    @objc func doneInvoiceDate() {
        invoiceDateChanged()
        invoiceDateTF.resignFirstResponder()
    }
    
    @objc func doneDueDate() {
        dueDateChanged()
        dueDateTF.resignFirstResponder()
    }
    
    func presentDatePickerPopover(for textField: UITextField, picker: UIDatePicker) {
        let pickerVC = UIViewController()
        pickerVC.preferredContentSize = CGSize(width: 320, height: 320)
        pickerVC.view.addSubview(picker)
        
        picker.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            picker.topAnchor.constraint(equalTo: pickerVC.view.topAnchor),
            picker.bottomAnchor.constraint(equalTo: pickerVC.view.bottomAnchor),
            picker.leadingAnchor.constraint(equalTo: pickerVC.view.leadingAnchor),
            picker.trailingAnchor.constraint(equalTo: pickerVC.view.trailingAnchor)
        ])
        
        pickerVC.modalPresentationStyle = .popover
        if let popover = pickerVC.popoverPresentationController {
            popover.sourceView = textField
            popover.sourceRect = textField.bounds
            popover.permittedArrowDirections = .up
            popover.delegate = self
        }
        
        present(pickerVC, animated: true, completion: nil)
    }
    
}

//extension InvoiceViewController: UISearchBarDelegate {
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        if searchText.isEmpty {
//            isSearching = false
//            customerTableView.isHidden = true
//        } else {
//            isSearching = true
//            filteredCustomers = customerVM.customers.filter { customer in
//                (customer.companyName?.lowercased().contains(searchText.lowercased()) ?? false)
//            }
//            customerTableView.reloadData()
//            customerTableView.isHidden = filteredCustomers.isEmpty
//        }
//    }
//
//    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
//        customerTableView.isHidden = true
//    }
//}

extension InvoiceViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        isSearching = true
        filteredCustomers = customerVM.customers
        customerTableView.reloadData()
        customerTableView.isHidden = filteredCustomers.isEmpty
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredCustomers = customerVM.customers
        } else {
            filteredCustomers = customerVM.customers.filter { customer in
                (customer.companyName?.lowercased().contains(searchText.lowercased()) ?? false)
            }
        }
        
        customerTableView.reloadData()
        customerTableView.isHidden = filteredCustomers.isEmpty
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        customerTableView.isHidden = true
        isSearching = false
    }
}
