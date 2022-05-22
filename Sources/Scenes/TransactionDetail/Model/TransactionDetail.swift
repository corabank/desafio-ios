import Foundation

struct TransactionDetail: Decodable {
    let type: TransactionType
    let method: TransactionMethod
    let value: Double
    let date: Date
    let sender: TransactionPerson
    let receiver: TransactionPerson
}

struct TransactionPerson: Decodable {
    let name: String
    let cpf: String
    let bankName: String
    let bankAgency: String
    let bankAccount: String
}

