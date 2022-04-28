import Foundation

final class StatementViewModel {
    private var view: StatementViewProtocol?
    private var coordinator: StatementCoordinatorProtocol?
    private var dataSource: StatementDataSourceProtocol?
    
    init() {}
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
    func tapBack() {
        coordinator?.back()
    }
    
    func tapShare() {
        print("share")
    }
}
