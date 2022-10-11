protocol StatementViewModelProtocol {
    func set(view: StatementViewProtocol)
    func set(coordinator: StatementCoordinatorProtocol)
    func set(dataSource: StatementDataSourceProtocol)
}
