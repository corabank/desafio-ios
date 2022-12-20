import UIKit

struct TransactionDetailViewModel: Equatable {
    private typealias Localizable = Strings.TransactionDetail
    private let transactionDetail: TransactionDetail
    
    init(transactionDetail: TransactionDetail) {
        self.transactionDetail = transactionDetail
    }
    
    var icon: UIImage {
        TransactionFormatterHelper.icon(for: transactionDetail.method, type: transactionDetail.type)
    }
    
    var description: String {
        TransactionFormatterHelper.description(for: transactionDetail.method, type: transactionDetail.type)
    }
    
    var dateTitle: String {
        switch transactionDetail.method {
        case .transfer:
            return Localizable.transferDate
        case .payment, .billet:
            return Localizable.paymentDate
        }
    }
    
    var formattedDate: String {
        let weekday = DateFormatter.relativeWeekday(from: transactionDetail.date)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let dayMonthYear = dateFormatter.string(from: transactionDetail.date)
        return "\(weekday) - \(dayMonthYear)".capitalizingFirstLetter()
    }
    
    var formattedValue: NSAttributedString? {
        transactionDetail.value.getCurrencyString().currencyWithBoldValue()
    }
    
    var shouldShowCancelButton: Bool {
        transactionDetail.type == .scheduled
    }
    
    var senderContent: TransactionUserContent {
        TransactionUserContent(transactionPerson: transactionDetail.sender, title: Localizable.sender)
    }
    
    var receiverContent: TransactionUserContent {
        TransactionUserContent(transactionPerson: transactionDetail.receiver, title: Localizable.receiver)
    }

}
