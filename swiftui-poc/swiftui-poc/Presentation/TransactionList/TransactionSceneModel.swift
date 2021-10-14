import Foundation
import UIKit

struct TransactionSceneModel: Identifiable {
    var id: String
    private(set) var value: String
    private(set) var buyer: BuyerSceneModel
    private(set) var paymentMethod: PaymentMethod
    private(set) var date: String
    private(set) var status: Status
    private(set) var taxes: String
    
    enum Status {
        case paid
        case notPaid
        case waitingPayment
        
        init(mapping model: TransactionModel.Status) {
            switch model {
            case .paid:             self = .paid
            case .notPaid, .unkown: self = .notPaid
            case .waitingPayment:   self = .waitingPayment
            }
        }
        
        var localizedDescription: String {
            switch self {
            case .paid:             return "Pago"
            case .notPaid:          return "Não Pago"
            case .waitingPayment:   return "Aguardando"
            }
        }
        
        var uiColor: UIColor {
            switch self {
            case .paid:             return UIColor(red: 0.31, green: 0.8, blue: 0.5, alpha: 1)
            case .notPaid:          return UIColor(red: 0.91, green: 0.14, blue: 0.18, alpha: 1)
            case .waitingPayment:   return UIColor(red: 0.08, green: 0.67, blue: 0.78, alpha: 1)
            }
        }
    }
    
    enum PaymentMethod {
        case creditCard
        case cash
        
        init(mapping model: TransactionModel.PaymentMethod) {
            switch model {
            case .creditCard:       self = .creditCard
            case .cash, .unkown:    self = .cash
            }
        }
        
        var localizedDescription: String {
            switch self {
            case .creditCard:   return "Cartão de Crédito"
            case .cash:         return "Dinheiro"
            }
        }
    }
}

extension TransactionSceneModel {
    init?(mapping model: TransactionModel) {
        self.id = model.id
        guard let value = CachedNumberFormatter.shared.currencyFormat().string(from: NSNumber(value: model.value)) else {
            return nil
        }
        self.value = value
        self.buyer = BuyerSceneModel(mapping: model.buyer)
        self.paymentMethod = PaymentMethod(mapping: model.paymentMethod)
        guard let unwrapped = model.date else {
            return nil
        }
        self.date = CachedDateFormatter.shared.presentationFormat().string(from: unwrapped)
        self.status = Status(mapping: model.status)
        guard let taxes = CachedNumberFormatter.shared.currencyFormat().string(from: NSNumber(value: model.taxes)) else {
            return nil
        }
        self.taxes = taxes
    }
    
    static func asArray(mapping models: [TransactionModel]) -> [TransactionSceneModel] {
        return models.compactMap { TransactionSceneModel(mapping: $0) }
    }
}
