struct CardStatement {
    let name: String
    let number: Int
    let financeItems: [FinanceItem]
}

struct FinanceItem {
    let date: String
    let title: String
    let value: Float
}
