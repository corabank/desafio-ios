protocol StatementDetailViewModelProtocol: AnyObject {
    func set(view: StatementDetailViewProtocol)
    func set(coordinator: StatementDetailCoordinatorProtocol)
    func set(statement: StatementItem, owner: Person)
}
