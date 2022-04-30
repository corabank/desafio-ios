protocol StatementDataSourceProtocol {
    func getStatements() -> [StatementDay]
    func getUser() -> Person
}
