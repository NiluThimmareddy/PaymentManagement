//
//  InvoiceDetailsViewController.swift
//  PaymentManagement
//
//  Created by praveenkumar on 24/04/25.
//

import UIKit

class InvoiceDetailsViewController: UIViewController {
    
    var callInvoiceItem : [invoiceItem] = [
        invoiceItem(
        rowKey: "1da4a6b7-40fa-421a-bbe5-60ff20b50270",
        itemId: "1da4a6b7-40fa-421a-bbe5-60ff20b50270",
        invoiceNumber: "1001",
        itemDetails: "Mobile",
        itemDescription: "12GB RAM",
        quantity: "2",
        price: "$50,000",
        tax: "$500",
        total: "$6,00,000"
        ),
        invoiceItem(
        rowKey: "1da4a6b7-40fa-421a-bbe5-60ff20b50270",
        itemId: "1da4a6b7-40fa-421a-bbe5-60ff20b50270",
        invoiceNumber: "1007",
        itemDetails: "Mobile",
        itemDescription: "12GB ram",
        quantity: "2",
        price: "$50,000",
        tax: "$500",
        total: "$6,00,000"
        ),
        invoiceItem(
        rowKey: "1f14ecdd-f7c8-4963-a9ce-9566d8206cfd",
        itemId: "1f14ecdd-f7c8-4963-a9ce-9566d8206cfd",
        invoiceNumber: "1006",
        itemDetails: "desk",
        itemDescription: "desk",
        quantity: "3",
        price: "$34",
        tax: "$33",
        total: "$135.66"
        ),
        invoiceItem(
        rowKey: "1f14ecdd-f7c8-4963-a9ce-9566d8206cfd",
        itemId: "1f14ecdd-f7c8-4963-a9ce-9566d8206cfd",
        invoiceNumber: "1006",
        itemDetails: "desk",
        itemDescription: "desk",
        quantity: "3",
        price: "$34",
        tax: "$33",
        total: "$135.66"
        ),
        invoiceItem(
            rowKey: "1da4a6b7-40fa-421a-bbe5-60ff20b50270",
            itemId: "1da4a6b7-40fa-421a-bbe5-60ff20b50270",
            invoiceNumber: "1001",
            itemDetails: "Mobile",
            itemDescription: "12GB RAM",
            quantity: "2",
            price: "$50,000",
            tax: "$500",
            total: "$6,00,000"
            ),
            invoiceItem(
            rowKey: "1da4a6b7-40fa-421a-bbe5-60ff20b50270",
            itemId: "1da4a6b7-40fa-421a-bbe5-60ff20b50270",
            invoiceNumber: "1007",
            itemDetails: "Mobile",
            itemDescription: "12GB ram",
            quantity: "2",
            price: "$50,000",
            tax: "$500",
            total: "$6,00,000"
            ),
            invoiceItem(
            rowKey: "1f14ecdd-f7c8-4963-a9ce-9566d8206cfd",
            itemId: "1f14ecdd-f7c8-4963-a9ce-9566d8206cfd",
            invoiceNumber: "1006",
            itemDetails: "desk",
            itemDescription: "desk",
            quantity: "3",
            price: "$34",
            tax: "$33",
            total: "$135.66"
            ),
            invoiceItem(
            rowKey: "1f14ecdd-f7c8-4963-a9ce-9566d8206cfd",
            itemId: "1f14ecdd-f7c8-4963-a9ce-9566d8206cfd",
            invoiceNumber: "1006",
            itemDetails: "desk",
            itemDescription: "desk",
            quantity: "3",
            price: "$34",
            tax: "$33",
            total: "$135.66"
            )
    ]
    var passData: InvoiceLabels?
    var invoiceHeaderView: invoiceDetailsHeaderView?
    private let invoiceVM = InvoiceViewModel()
    
    //OUTLETS
    @IBOutlet weak var invoiceHeaderViewView: UIView!
    @IBOutlet weak var invoiceHeaderScrollView: UIScrollView!
    @IBOutlet weak var invoiceHeaderScrollViewContentView: UIView!
    @IBOutlet weak var invoiceHeaderStackView: UIStackView!
    @IBOutlet weak var invoiceHeaderViewScrollContentWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var printButton: UIButton!
    @IBOutlet weak var copyRightLbl: UILabel!
    @IBOutlet weak var remarksContentLbl: UILabel!
    @IBOutlet weak var subTotalLbl: UILabel!
    @IBOutlet weak var totalTaxLbl: UILabel!
    @IBOutlet weak var grandTotalLbl: UILabel!
    @IBOutlet weak var invoiceDetailsTVHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var invoiceDetailsTV: UITableView!
    @IBOutlet weak var invoiceSmallTableBackView: UIView!
    @IBOutlet weak var invoiceNumberLbl: UILabel!
    @IBOutlet weak var invoiceDateLbl: UILabel!
    @IBOutlet weak var invoiceTermsLbl: UILabel!
    @IBOutlet weak var invoiceDueDateLbl: UILabel!
    @IBOutlet weak var ShipToStateLbl: UILabel!
    @IBOutlet weak var ShipToCityLbl: UILabel!
    @IBOutlet weak var ShipToAddressLbl: UILabel!
    @IBOutlet weak var ShipToLbl: UILabel!
    @IBOutlet weak var billToStateLbl: UILabel!
    @IBOutlet weak var billToCityLbl: UILabel!
    @IBOutlet weak var billToAddressLbl: UILabel!
    @IBOutlet weak var billToNameLbl: UILabel!
    @IBOutlet weak var billToLbl: UILabel!
    @IBOutlet weak var companyCountryLbl: UILabel!
    @IBOutlet weak var companyStateLbl: UILabel!
    @IBOutlet weak var companyCityLbl: UILabel!
    @IBOutlet weak var invoiceLineView: UIView!
    @IBOutlet weak var companyLogoImage: UIImageView!
    @IBOutlet weak var companyAddressLbl: UILabel!
    @IBOutlet weak var companyNameLbl: UILabel!
    @IBOutlet weak var invoiceScrollView: UIScrollView!
    @IBOutlet weak var invoiceContentView: UIView!
   
    @IBOutlet weak var invoiceContentViewHeightConstraint: NSLayoutConstraint!
    
    var cusomerVM = CustomerViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        invoiceSmallTableBackView.layer.borderWidth = 1
        invoiceSmallTableBackView.layer.borderColor = UIColor(red: 224/255, green: 224/255, blue: 224/255, alpha: 1).cgColor
        invoiceDetailsTV.register(UINib(nibName: "invoiceDetailsTVC", bundle: nil), forCellReuseIdentifier: "invoiceDetailsTVC")
        printButton.layer.cornerRadius = 10
        fetchCustomerData()
        invoiceHeaderScrollView.delegate = self
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let numberOfRows = invoiceDetailsTV.numberOfRows(inSection: 0)
        let rowHeight: CGFloat = 50
        let baseTableHeight: CGFloat = 50
        let defaultContentViewHeight: CGFloat = 836
        let tableViewHeight = max(baseTableHeight, CGFloat(numberOfRows) * rowHeight)
        invoiceDetailsTVHeightConstraint.constant = tableViewHeight
        invoiceContentViewHeightConstraint.constant = defaultContentViewHeight + tableViewHeight - baseTableHeight
        invoiceContentView.layoutIfNeeded()
    }
    func fetchCustomerData(){
        Task{
            invoiceVM.fetchCustomers { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let customer):
                        print(customer)
                        
                        self?.invoiceDetailsTV.reloadData()
                case .failure(let error ) :
                    print("Error: \(error)")
                }
            }
            }
        }
    }
    
    func addNewCustomer(){
        Task{
            invoiceVM.addCustomer(invoiceVM.newInvoice, completion: { [weak self] customerarray, error in
                if let error = error{
                    print("Failed to add: \(error)")
                }else if let customerarray = customerarray {
                   DispatchQueue.main.async {
                          self?.invoiceDetailsTV.reloadData()
                    }
                 
                    print("Succcessfully added. Totla Count \(String(describing: customerarray.count)) \n \(customerarray)")
                }
            })
        }
    }
    
    
    func updateCustomer(){
            
             
        invoiceVM.updateCustomer(invoiceVM.updateInvoice, completion: { [weak self] customerarray, error in
                if let error = error{
                    print("Failed to update: \(error)")
                }else if let list = customerarray{
                        DispatchQueue.main.async {
                              self?.invoiceDetailsTV.reloadData()
                        }
                     
                    print("Succcessfully Customer updated :  \n \(list)")
                }
            })
         
    }
    
    
    func deleteCustomer(){
           
   
        invoiceVM.deleteCustomer(invoiceVM.invoiceToDelete) { [weak self] custoemrArray, error in
                if let error = error{
                    print("Failed to delete Customer: \(error)")
                }else if let list = custoemrArray{
                       DispatchQueue.main.async {
                              self?.invoiceDetailsTV.reloadData()
                        }
                     
                    print("Succcessfully Invoice updeleteddated :  \n \(list)")
                }
            }
         
    }

    deinit {
        print("InvoiceDetailsViewController deinitialized...")
    }
    
    
    @IBAction func printButton(_ sender: Any) {
        
        
           invoiceContentView.layoutIfNeeded()

         
           let printController = UIPrintInteractionController.shared
           let printInfo = UIPrintInfo(dictionary: nil)
           printInfo.outputType = .general
           printInfo.jobName = "Invoice"
           printController.printInfo = printInfo

        
           let renderer = UIGraphicsPDFRenderer(bounds: invoiceContentView.bounds)
           let data = renderer.pdfData { context in
               context.beginPage()
               invoiceContentView.layer.render(in: context.cgContext)
           }

           printController.printingItem = data

           printController.present(animated: true) { (_, completed, _) in
               self.invoiceContentView.isHidden = false
           }
    }
    
}
extension InvoiceDetailsViewController: UITableViewDelegate, UITableViewDataSource, InvoiceScrollSyncDelegate,UIScrollViewDelegate{
    
    func didScroll(contentOffset: CGPoint) {
        invoiceHeaderScrollView.contentOffset = contentOffset
        for cell in invoiceDetailsTV.visibleCells {
            if let invoiceCell = cell as? invoiceDetailsTVC {
                invoiceCell.scrollView.contentOffset = contentOffset
            }
        }
    }
    

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard scrollView == invoiceHeaderScrollView else { return }
        let offset = scrollView.contentOffset
        for cell in invoiceDetailsTV.visibleCells {
            if let invoiceCell = cell as? invoiceDetailsTVC {
                invoiceCell.scrollView.contentOffset = offset
            }
        }
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return callInvoiceItem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "invoiceDetailsTVC", for: indexPath) as? invoiceDetailsTVC else {
            return UITableViewCell()
        }
        
        let item = callInvoiceItem[indexPath.row]
        //            invoiceVM.invoices[indexPath.row]
        cell.scrollDelegate = self
        cell.configureCell(sNo: indexPath.row + 1, with: item)
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}


//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//    if let headerView = Bundle.main.loadNibNamed("invoiceDetailsHeaderView", owner: self, options: nil)?.first as? invoiceDetailsHeaderView {
//                self.invoiceHeaderView = headerView
//                headerView.scrollDelegate = self
//                headerView.scrollView.delegate = headerView
//                return headerView
//        }
//            return nil
//    }
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//            return 50
//
//    }
    
