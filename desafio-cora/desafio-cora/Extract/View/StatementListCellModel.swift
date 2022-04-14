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
        switch transaction.transactionStatus.transactionEntry {
        case .input:
            return Colors.blue
        case .output:
            return Colors.offBlack
        }
    }
    
    func image() -> UIImage? {
        var image: UIImage?
        switch transaction.transactionStatus.transactionType {
        case .transfer:
            if transaction.transactionStatus.status == .complete,
               transaction.transactionStatus.transactionEntry == .input {
                image = Images.downArrow
            } else if transaction.transactionStatus.status == .complete,
                      transaction.transactionStatus.transactionEntry == .output {
                image = Images.upArrow
            } else if transaction.transactionStatus.status == .reversed {
                image = Images.returnArrow
            } else {
                image = Images.timeClock
            }
        case .payment:
            if transaction.transactionStatus.status == .complete,
               transaction.transactionStatus.transactionEntry == .input {
                image = Images.downArrow
            } else if transaction.transactionStatus.status == .reversed,
                      transaction.transactionStatus.transactionEntry == .output {
                image = Images.returnArrow
            }
        case .ticket:
            image = Images.barCode
        }
        return image
    }
        
    func transactionText() -> String {
        var text: String = ""
        switch transaction.transactionStatus.transactionType {
        case .transfer:
            if transaction.transactionStatus.status == .complete,
               transaction.transactionStatus.transactionEntry == .input {
                text = Strings.transferRecieved
            } else if transaction.transactionStatus.status == .reversed,
                      transaction.transactionStatus.transactionEntry == .output {
                text = Strings.transferReversed
            } else if transaction.transactionStatus.status == .complete,
                      transaction.transactionStatus.transactionEntry == .output {
                text = Strings.transferSent
            } else {
                text = Strings.transferScheduled
            }
        case .payment:
            if transaction.transactionStatus.status == .complete,
               transaction.transactionStatus.transactionEntry == .input {
                text = Strings.paymentRecieved
            } else {
                text = Strings.paymentReversed
            }
        case .ticket:
            if transaction.transactionStatus.status == .complete,
               transaction.transactionStatus.transactionEntry == .input {
                text = Strings.ticketDeposit
            } else {
                text = Strings.ticketPaid
            }
        }
        return text
    }
    
    func value() -> NSAttributedString {
        let attributed = NSMutableAttributedString(string: "R$ \(formatNumberToDecimal())",
                                                   attributes: [NSAttributedString.Key.font: Typography.getFont(.bold(size: 16))(),
                                                                NSAttributedString.Key.foregroundColor: tintColor])
        if transaction.transactionStatus.status == .reversed {
            attributed.addAttribute(NSAttributedString.Key.strikethroughStyle,
                                    value: 1,
                                    range: NSRange(location: 0, length: attributed.length))
        }
        return attributed
    }
    
    private func formatNumberToDecimal() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.groupingSeparator = "."
        return numberFormatter.string(from: NSNumber(value: transaction.transactionValue)) ?? "Valor indefinido"
    }
}
