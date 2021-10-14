import Foundation
@testable import swiftui_poc

extension TransactionResponse: Equatable {
    
    public static func == (lhs: TransactionResponse, rhs: TransactionResponse) -> Bool {
        return lhs.transactions == rhs.transactions
    }
}

extension TransactionEntity: Equatable {
    
    public static func == (lhs: TransactionEntity, rhs: TransactionEntity) -> Bool {
        return  lhs.id == rhs.id                        && lhs.value == rhs.value   &&
                lhs.date == rhs.date                    && lhs.status == rhs.status &&
                lhs.paymentMethod == rhs.paymentMethod  && lhs.taxes == rhs.taxes   &&
                lhs.buyer == rhs.buyer
    }
}

extension BuyerEntity: Equatable {
    
    public static func == (lhs: BuyerEntity, rhs: BuyerEntity) -> Bool {
        return lhs.name == rhs.name && lhs.email == rhs.email
    }
}

extension TransactionModel: Equatable {
    
    public static func == (lhs: TransactionModel, rhs: TransactionModel) -> Bool {
        return  lhs.id == rhs.id                        && lhs.value == rhs.value   &&
                lhs.date == rhs.date                    && lhs.status == rhs.status &&
                lhs.paymentMethod == rhs.paymentMethod  && lhs.taxes == rhs.taxes   &&
                lhs.buyer == rhs.buyer
    }
}

extension BuyerModel: Equatable {
    
    public static func == (lhs: BuyerModel, rhs: BuyerModel) -> Bool {
        return lhs.name == rhs.name && lhs.email == rhs.email
    }
}

extension TransactionSceneModel: Equatable {
    
    public static func == (lhs: TransactionSceneModel, rhs: TransactionSceneModel) -> Bool {
        return  lhs.id == rhs.id                        && lhs.value == rhs.value   &&
                lhs.date == rhs.date                    && lhs.status == rhs.status &&
                lhs.paymentMethod == rhs.paymentMethod  && lhs.taxes == rhs.taxes   &&
                lhs.buyer == rhs.buyer
    }
}

extension BuyerSceneModel: Equatable {
    
    public static func == (lhs: BuyerSceneModel, rhs: BuyerSceneModel) -> Bool {
        return lhs.name == rhs.name && lhs.email == rhs.email
    }
}
