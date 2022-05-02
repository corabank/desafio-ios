protocol StatementViewDelegate {
    func tapBack()
    func tapShare()
    func selectItem(item: StatementItem)
    func allStatements() -> [StatementDay]
    func incomeStatements() -> [StatementDay]
    func outcomeStatements() -> [StatementDay]
    func futureStatements() -> [StatementDay]
}
