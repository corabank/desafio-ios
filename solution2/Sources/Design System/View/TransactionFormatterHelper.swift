import class UIKit.UIImage

enum TransactionFormatterHelper {
    // MARK: Icons
    
    static func icon(for method: TransactionMethod, type: TransactionType) -> UIImage {
        switch method {
        case .transfer, .payment:
            return transferIcon(for: type)
        case .billet:
            return Images.icBarCode.image
        }
    }
    
    private static func transferIcon(for type: TransactionType) ->  UIImage {
        switch type {
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
    
    // MARK: Descriptions
    
    private typealias Localizable = Strings.TransactionDescription
    
    static func description(for method: TransactionMethod, type: TransactionType) -> String {
        switch method {
        case .transfer:
            return transferDescription(for: type)
        case .payment:
            return paymentDescription(for: type)
        case .billet:
            return billetDescription(for: type)
        }
    }
    
    private static func transferDescription(for type: TransactionType) -> String {
        switch type {
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
    
    private static func paymentDescription(for type: TransactionType) -> String {
        switch type {
        case .input:
            return Localizable.paymentReceived
        case .reversed:
            return Localizable.paymentReversed
        default:
            return ""
        }
    }
    
    private static func billetDescription(for type: TransactionType) -> String {
        switch type {
        case .input:
            return Localizable.billetDeposit
        case .output:
            return Localizable.billetPaid
        default:
            return ""
        }
    }
}
