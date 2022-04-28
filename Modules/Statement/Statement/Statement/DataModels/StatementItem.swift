struct StatementItem {
    let person: Person
    let status: String
    let paymentType: PaymentType
    let paymentStatus: PaymentStatus
    let value: Float
    let time: String
    let state: StateType
    let type: BankType
}

enum StateType { case income, outcome, future }
enum PaymentType { case transfer, ticket, payement }
enum PaymentStatus { case sent, reversal }
enum BankType { case cpf, cnpj }
