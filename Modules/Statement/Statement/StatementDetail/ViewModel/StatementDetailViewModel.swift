final class StatementDetailViewModel {
    private weak var view: StatementDetailViewProtocol?
    private var coordinator: StatementDetailCoordinatorProtocol?

    init() {}
    
    private func textGenerate(_ status: String, _ firstWord: String) -> String {
        let first = status.split(separator: " ").first?.lowercased()
        let connection = (first?.last == "a") ? "da" : "do"
        guard let first = first else { return "" }
        return "\(firstWord) \(connection) \(first)"
    }
}

extension StatementDetailViewModel: StatementDetailViewModelProtocol {
    func set(view: StatementDetailViewProtocol) {
        self.view = view
    }
    
    func set(coordinator: StatementDetailCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
    func set(statement: StatementItem, owner: Person) {
        if (statement.paymentStatus != .outcome) {
            view?.setInto(statement: statement,
                          from: statement.person, to: owner,
                          navigationTitle: textGenerate(statement.status, "Detalhe"),
                          title: textGenerate(statement.status, "Data"))
        } else {
            view?.setInto(statement: statement,
                          from: owner, to: statement.person,
                          navigationTitle: textGenerate(statement.status, "Detalhe"),
                          title: textGenerate(statement.status, "Data"))
        }
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
