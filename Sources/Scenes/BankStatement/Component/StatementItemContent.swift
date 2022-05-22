import UIKit

struct StatementItemContent {
    private let transaction: Transaction
    
    init(transaction: Transaction) {
        self.transaction = transaction
    }
    
    var icon: UIImage {
        TransactionFormatterHelper.icon(for: transaction.method, type: transaction.type)
    }
    
    var tintColor: UIColor {
        guard case .input = transaction.type else {
            return Colors.offBlack.color
        }
        
        return Colors.blue00.color
    }
    
    var formattedValue: NSAttributedString? {
        guard let currencyString = transaction.value.getCurrencyString().currencyWithBoldValue() else { return nil }
        
        if case .reversed = transaction.type {
            currencyString.addAttribute(.strikethroughStyle,
                                         value: NSUnderlineStyle.single.rawValue,
                                         range: NSRange(currencyString.string.startIndex..., in: currencyString.string))
        }
        return currencyString
    }
    
    var description: String {
        TransactionFormatterHelper.description(for: transaction.method, type: transaction.type)
    }
    
    var name: String {
        transaction.name
    }
    
    var hour: String {
        transaction.hour
    }
}
