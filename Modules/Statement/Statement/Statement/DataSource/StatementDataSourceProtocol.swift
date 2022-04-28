protocol StatementDataSourceProtocol {
    func getStatements() -> [StatementSection]
    func getUser() -> Person
}
