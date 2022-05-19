import UIKit

struct TransactionDetailViewModel {
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
        case .payment:
            return Localizable.paymentDate
        case .billet:
            return ""
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
}
