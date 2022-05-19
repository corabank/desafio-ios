import UIKit

struct StatementItemContent {
    private let transaction: Transation
    
    init(transaction: Transation) {
        self.transaction = transaction
    }
    
    var icon: UIImage {
        switch transaction.method {
        case .tranfer, .payment:
            return transferIcon
        case .billet:
            return Images.icBarCode.image
        }
    }
    
    var tintColor: UIColor {
        guard case .input = transaction.type else {
            return Colors.offBlack.color
        }
        
        return Colors.blue00.color
    }
    
    var formattedValue: NSAttributedString? {
        let currencyString = transaction.value.getCurrencyString()
        let boldText = currencyString.replacingOccurrences(of: "R$", with: "")
        let attributedText = currencyString.withBoldText(text: boldText,
                                                         regularFont: Font.Regular.tertiaryTitle,
                                                         boldFont: Font.Highlighted.tertiaryTitle)
        
        if case .reversed = transaction.type {
            attributedText?.addAttribute(.strikethroughStyle,
                                         value: NSUnderlineStyle.single.rawValue,
                                         range: NSRange(currencyString.startIndex..., in: currencyString))
        }
        return attributedText
    }
    
    var description: String {
        switch transaction.method {
        case .tranfer:
            return transferDescription
        case .payment:
            return paymentDescription
        case .billet:
            return billetDescription
        }
    }
    
    var name: String {
        transaction.name
    }
    
    var hour: String {
        transaction.hour
    }
    
    // MARK: Private vars
    
    private typealias Localizable = Strings.BankStatement.TransactionDescription
    
    private var transferIcon: UIImage {
        switch transaction.type {
        case .input:
            return Images.icArrowDownIn.image
        case .output:
            return Images.icArrowUpOut.image
        case .reversed:
            return Images.icArrowReturn.image
        case .scheduled:
            return Images.icTimeClock.image
        }
    }
    
    private var transferDescription: String {
        switch transaction.type {
        case .input:
            return Localizable.transferReceived
        case .output:
            return Localizable.trasferSent
        case .reversed:
            return Localizable.trasferReversed
        case .scheduled:
            return Localizable.trasferScheduled
        }
    }
    
    private var paymentDescription: String {
        switch transaction.type {
        case .input:
            return Localizable.paymentReceived
        case .reversed:
            return Localizable.paymentReversed
        default:
            return ""
        }
    }
    
    private var billetDescription: String {
        switch transaction.type {
        case .input:
            return Localizable.billetDeposit
        case .output:
            return Localizable.billetPaid
        default:
            return ""
        }
    }
}
