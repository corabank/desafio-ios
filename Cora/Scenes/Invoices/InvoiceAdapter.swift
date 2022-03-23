final class InvoiceAdapter: InvoiceAdapterType {
    func adapt(models: [TransactionModel]) -> [InvoiceViewModel] {
        models.map {
            InvoiceViewModel(date: $0.transactionDate,
                             title: $0.transactionName,
                             subtitle: $0.taxDescription,
                             value: $0.transactionValue,
                             subValue: $0.taxValue,
                             isInvoicePayment: $0.isInvoicePayment)
        }
    }
}
