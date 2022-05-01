final class StatementDetailViewModel {
    private var view: StatementDetailViewProtocol?
    private var coordinator: StatementDetailCoordinatorProtocol?

    init() {}
    
    private func titleString(_ type: PaymentType) -> String {
        switch type {
        case .pay:
            return "Data da tranferência"
        case .ticket:
            return "Data do boleto"
        case .reversal:
            return "Data do estorno"
        case .future:
            return "Data da tranferência"
        }
    }
    
    private func navigationTitle(_ status: String) -> String {
        let first = status.split(separator: " ").first?.lowercased()
        let connection = (first?.last == "a") ? "da" : "do"
        guard let first = first else { return "" }
        return "Detalhe \(connection) \(first)"
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
        if (statement.paymentStatus == .income) {
            view?.setInto(statement: statement,
                          from: statement.person, to: owner,
                          navigationTitle: navigationTitle(statement.status),
                          title: titleString(statement.paymentType))
        } else {
            view?.setInto(statement: statement,
                          from: owner, to: statement.person,
                          navigationTitle: navigationTitle(statement.status),
                          title: titleString(statement.paymentType))
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
