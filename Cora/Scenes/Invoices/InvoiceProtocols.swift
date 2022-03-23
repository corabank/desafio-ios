protocol InvoicePresenterType: AnyObject {
    func loadTransactions()
}

protocol InvoiceControllerType: AnyObject {
    func showTransactions(transactions: [InvoiceViewModel])
}

protocol InvoiceAdapterType: AnyObject {
    func adapt(models: [TransactionModel]) -> [InvoiceViewModel]
}
