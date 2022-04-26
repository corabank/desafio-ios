import Foundation

final class StatementViewModel {
    private var view: StatementViewProtocol?
    private var coordinator: StatementCoordinatorProtocol?
    
    init() {}
}

extension StatementViewModel: StatementViewModelProtocol {
    func set(coordinator: StatementCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
    func set(view: StatementViewProtocol) {
        self.view = view
    }
}

extension StatementViewModel: StatementViewDelegate {
}
