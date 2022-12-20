import Foundation

final class StatementViewModel {
    private weak var view: StatementViewProtocol?
    private weak var dataSource: StatementDataSourceProtocol?
    private var coordinator: StatementCoordinatorProtocol?
    
    private lazy var statements: [StatementDay] = []
    
    init() {}
    
    private func filterItens(_ status: PaymentStatus) -> [StatementDay] {
        var filtered = statements
        
        for i in filtered.indices {
            filtered[i].setItens(new: filtered[i].itens.filter { $0.paymentStatus == status })
        }

        return filtered.filter { $0.itens.count > 0 }
    }
}

extension StatementViewModel: StatementViewModelProtocol {
    func set(coordinator: StatementCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
    func set(view: StatementViewProtocol) {
        self.view = view
    }
    
    func set(dataSource: StatementDataSourceProtocol) {
        self.dataSource = dataSource
    }
}

extension StatementViewModel: StatementViewDelegate {
    func allStatements() -> [StatementDay] {
        if (statements.count == 0) { statements = dataSource?.getStatements() ?? [] }
        return statements
    }
    
    func incomeStatements() -> [StatementDay] {
        return filterItens(.income)
    }
    
    func outcomeStatements() -> [StatementDay] {
        return filterItens(.outcome)
    }
    
    func futureStatements() -> [StatementDay] {
        return filterItens(.future)
    }
    
    func selectItem(item: StatementItem) {
        coordinator?.goToDetail(item: item)
    }
    
    func tapBack() {
        coordinator?.back()
    }
    
    func tapShare() {
        print("share")
    }
}
