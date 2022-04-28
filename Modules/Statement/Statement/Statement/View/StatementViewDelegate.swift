protocol StatementViewDelegate: AnyObject {
    func tapBack()
    func tapShare()
    func getData() -> [StatementSection]?
}
