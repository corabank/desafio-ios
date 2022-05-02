protocol StatementDataSourceProtocol: AnyObject {
    func getStatements() -> [StatementDay]
    func getUser() -> Person
}
