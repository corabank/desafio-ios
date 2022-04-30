struct StatementItem {
    let person: Person
    let status: String
    let paymentType: PaymentType
    let paymentStatus: PaymentStatus
    let value: Float
    let time: String
    let type: BankType
    
    func realValue() -> Float {
        return (paymentStatus == .outcome) ? (value * -1) : value
    }
}

struct StatementDay {
    let date: Date
    let itens: [StatementItem]

    func total() -> Float {
        return itens.map({
            ($0.paymentStatus != .reverse) ?
            $0.realValue() : 0
        }).reduce(0, +)
    }
}

enum PaymentType { case pay, ticket, reversal, future }
enum PaymentStatus { case income, outcome, reverse }
enum BankType { case cpf, cnpj }
