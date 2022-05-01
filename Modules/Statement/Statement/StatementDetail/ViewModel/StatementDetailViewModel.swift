final class StatementDetailViewModel {
    private var view: StatementDetailViewProtocol?
    private var coordinator: StatementDetailCoordinatorProtocol?

    init() {}
}

extension StatementDetailViewModel: StatementDetailViewModelProtocol {
    func set(view: StatementDetailViewProtocol) {
        self.view = view
    }
    
    func set(coordinator: StatementDetailCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
    func set(statement: StatementItem, owner: Person) {
        view?.setInto(statement: statement, owner: owner)
    }
}

extension StatementDetailViewModel: StatementDetailViewDelegate {
    func tapBack() {
        coordinator?.back()
    }
    
    func tapShare() {
        print("share")
    }
    
    func tapCancel() {
        print("cancel")
    }
}
