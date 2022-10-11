public struct StatementItem {
    let uuid: UUID
    let person: Person
    let status: String
    let paymentType: PaymentType
    let paymentStatus: PaymentStatus
    let value: Float
    let time: String
    let type: BankType
    let date: Date
    let desc: String
}

struct StatementDay {
    let uuid: UUID
    let total: String
    let date: Date
    var itens: [StatementItem]
    
    mutating func setItens(new: [StatementItem]) {
        itens = new
    }
}

enum PaymentType { case pay, ticket, reversal, future }
enum PaymentStatus { case income, outcome, reverse, future }
enum BankType { case cpf, cnpj }
