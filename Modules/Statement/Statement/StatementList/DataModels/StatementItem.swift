struct StatementItem {
    let person: Person
    let status: String
    let paymentType: PaymentType
    let paymentStatus: PaymentStatus
    let value: Float
    let time: String
    let state: StateType
    let type: BankType
    
    func realValue() -> Float {
        return (paymentStatus == .reversal) ? (value * -1) : value
    }
}

struct StatementDay {
    let date: Date
    let itens: [StatementItem]
    
    func total() -> Float {
        return itens.map({$0.realValue()}).reduce(0, +)
    }
}

enum StateType { case income, outcome, future }
enum PaymentType { case transfer, ticket, payement }
enum PaymentStatus { case sent, reversal }
enum BankType { case cpf, cnpj }
