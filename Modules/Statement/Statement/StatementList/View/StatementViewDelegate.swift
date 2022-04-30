protocol StatementViewDelegate: AnyObject {
    func tapBack()
    func tapShare()
    func getData() -> [StatementDay]?
    func selectItem(item: StatementItem)
}
