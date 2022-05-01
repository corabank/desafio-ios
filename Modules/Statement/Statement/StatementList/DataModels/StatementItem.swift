public struct StatementItem {
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
    let total: String
    let date: Date
    let itens: [StatementItem]
}

enum PaymentType { case pay, ticket, reversal, future }
enum PaymentStatus { case income, outcome, reverse }
enum BankType { case cpf, cnpj }
