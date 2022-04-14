import Foundation
import UIKit
struct StatementListCellModel {
    private var transaction: TransactionDetail
    
    init(transaction: TransactionDetail) {
        self.transaction = transaction
    }
    
    var name: String {
        transaction.customerName
    }
    
    var hour: String {
        transaction.transactionHour
    }
    
    var tintColor: UIColor {
        TransactionColor.getColor(.color(typeEntry: transaction.transactionStatus.transactionEntry))()
    }
    
    func image() -> UIImage? {
        TransacionImage.getImage(.image(transaction: transaction))()
    }
    
    func transactionText() -> String {
        TransactionText.getText(.text(transaction: transaction))()
    }
    
    func value() -> NSAttributedString {
        let attributed = NSMutableAttributedString(string: CurrencyString.getCurrency(.money(value: transaction.transactionValue))(),
                                                   attributes: [NSAttributedString.Key.font: Typography.getFont(.bold(size: 16))(),
                                                                NSAttributedString.Key.foregroundColor: tintColor])
        if transaction.transactionStatus.status == .reversed {
            attributed.addAttribute(NSAttributedString.Key.strikethroughStyle,
                                    value: 1,
                                    range: NSRange(location: 0, length: attributed.length))
        }
        return attributed
    }
}
