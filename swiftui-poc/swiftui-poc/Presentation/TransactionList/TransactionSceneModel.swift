import Foundation
import UIKit

struct TransactionRowSceneModel: Identifiable {
    var id: String
    private(set) var value: String
    private(set) var buyerEmail: String
    private(set) var status: Status
    private(set) var date: String
    
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
}

extension TransactionRowSceneModel {
    init?(mapping model: TransactionModel) {
        self.id = model.id
        let number = NSNumber(value: model.value)
        guard let value = CachedNumberFormatter.shared.currencyFormat().string(from: number) else {
            return nil
        }
        self.value = value
        self.buyerEmail = model.buyer.email
        self.status = TransactionRowSceneModel.Status(mapping: model.status)
        guard let unwrapped = model.date else {
            return nil
        }
        self.date = CachedDateFormatter.shared.presentationFormat().string(from: unwrapped)
    }
    
    static func asArray(mapping models: [TransactionModel]) -> [TransactionRowSceneModel] {
        return models.compactMap { TransactionRowSceneModel(mapping: $0) }
    }
}
