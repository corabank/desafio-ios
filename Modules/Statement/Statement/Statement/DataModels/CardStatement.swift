struct StatementItem {
    let recipient: Person
    let payer: Person
    let status: String
    let value: Float
    let time: String
    let date: String
    let state: StateType
}

enum StateType { case income, outcome, future }

struct StatementSection {
    let itens: [StatementItem]
}

struct Person {
    let name: String
    let cpf: String
    let bank: String
    let agency: String
    let account: String
}
