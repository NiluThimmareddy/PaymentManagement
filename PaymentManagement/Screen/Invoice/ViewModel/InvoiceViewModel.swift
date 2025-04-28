import Foundation
class InvoiceViewModel {
    
    private let genericViewModel =  GenericViewModel(service: JsonFileManager<invoiceItem>(filename: Constant.JsonFileName.invoiceItemJson, idMatcher: {$0.itemId == $1.itemId}))
    
    // Sample invoices for testing
    let newInvoice = invoiceItem(
        partitionKey: "InvoiceItems",
        rowKey: nil,
        itemId: nil,
        invoiceNumber: "INV-1002",
        itemDetails: "Invoice for purchase",
        itemDescription: "Electronics purchase",
        quantity: "2",
        price: "500",
        tax: "50",
        total: "1050"
    )
    
    let updateInvoice = invoiceItem(
        partitionKey: "InvoiceItems",
        rowKey: "71a55052-26f2-4e4a-a23e-27b3fa648ad7",
        itemId: "71a55052-26f2-4e4a-a23e-27b3fa648ad7",
        invoiceNumber: "INV-1001",
        itemDetails: "Invoice for purchase",
        itemDescription: "Electronics purchase",
        quantity: "2",
        price: "500",
        tax: "50",
        total: "1050"
    )
    
    let invoiceToDelete = invoiceItem(
        partitionKey: "InvoiceItems",
        rowKey: "71a55052-26f2-4e4a-a23e-27b3fa648ad7",
        itemId: "71a55052-26f2-4e4a-a23e-27b3fa648ad7",
        invoiceNumber: "INV-1001",
        itemDetails: "Invoice for purchase",
        itemDescription: "Electronics purchase",
        quantity: "2",
        price: "500",
        tax: "50",
        total: "1050"
    )
    
    var invoices: [invoiceItem] {
        return genericViewModel.items
    }
    
    
    
    func fetchCustomers(completion: @escaping (Result<[invoiceItem],Error>) -> Void) {
        genericViewModel.fetchData(completion: completion)
    }
    
    func addCustomer(_ invoice: invoiceItem, completion: @escaping ([invoiceItem]?,Error?) -> Void){
       
        genericViewModel.addData(newData: invoice, completion: completion)
    }
    
    func updateCustomer(_ invoice: invoiceItem, completion: @escaping ([invoiceItem]?, Error?) -> Void) {
        genericViewModel.updateData(invoice, completion: completion)
    }
    
    func deleteCustomer(_ invoice: invoiceItem, completion: @escaping ([invoiceItem]?, Error?) -> Void) {
        genericViewModel.deleteData(invoice, completion: completion)
    }
    
}
