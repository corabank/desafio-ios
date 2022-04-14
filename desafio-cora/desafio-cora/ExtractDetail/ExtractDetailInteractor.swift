import Foundation
import UIKit

protocol ExtractDetailInteracting: AnyObject {
    func getUserSentData() -> UserData
    func getUserRecievedData() -> UserData
    func getTransactionType() -> String
    func getTransactionValue() -> String
    func getTransactionDay() -> String
    func getTransactionImage() -> UIImage?
    func getTransactionColor() -> UIColor
    func showCancelButton() -> Bool
    func share()
    func cancelTransaction()
}

final class ExtractDetailInteractor {
    private let presenter: ExtractDetailPresenting
    private let transaction: TransactionDetail
    private let transactionDay: String
    init(presenter: ExtractDetailPresenting, transaction: TransactionDetail, transactionDay: String) {
        self.presenter = presenter
        self.transaction = transaction
        self.transactionDay = transactionDay
    }
}

// MARK: - ExtractDetailInteracting
extension ExtractDetailInteractor: ExtractDetailInteracting {
    func getUserSentData() -> UserData {
        transaction.userSent ?? UserData(name: "", cpf: "", bank: "", agency: "", account: "")
    }
    
    func getUserRecievedData() -> UserData {
        transaction.userRecieved ?? UserData(name: "", cpf: "", bank: "", agency: "", account: "")
    }
    
    func getTransactionType() -> String {
        TransactionText.getText(.text(transaction: transaction))()
    }
    
    func getTransactionDay() -> String {
        transactionDay
    }
    
    func getTransactionValue() -> String {
        CurrencyString.getCurrency(.money(value: transaction.transactionValue))()
    }
    
    func getTransactionImage() -> UIImage? {
        TransacionImage.getImage(.image(transaction: transaction))()
    }
    
    func getTransactionColor() -> UIColor {
        TransactionColor.getColor(.color(typeEntry: transaction.transactionStatus.transactionEntry))()
    }
    
    func showCancelButton() -> Bool {
        transaction.transactionStatus.status != .future 
    }
    
    func share() {
        presenter.didNextStep(action: .share)
    }
    
    func cancelTransaction() {
        presenter.didNextStep(action: .cancelTransaction)
    }
}
