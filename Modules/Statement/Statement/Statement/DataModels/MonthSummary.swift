struct MonthSummary {
    let month: String
    let current: Float
    let state: State
    let limit: Float
    let dueDate: String
}

enum State { case current, paid, due }
