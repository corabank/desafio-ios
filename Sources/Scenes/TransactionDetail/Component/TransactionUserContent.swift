import UIKit

struct TransactionUserContent {
    private typealias Localizable = Strings.TransactionDetail
    private let transactionPerson: TransactionPerson
    let title: String
    
    init(transactionPerson: TransactionPerson, title: String) {
        self.transactionPerson = transactionPerson
        self.title = title
    }

    var name: String {
        transactionPerson.name
    }
    
    var cpf: String {
        Localizable.cpf(transactionPerson.cpf)
    }

    var bankName: String {
        transactionPerson.bankName
    }
    
    var backInfo: String {
        Localizable.bankInfo(transactionPerson.bankAgency, transactionPerson.bankAccount)
    }

}
