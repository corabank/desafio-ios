import UIKit

final class StatementDetailCoordinator {

    private var navigation: UINavigationController?
    
    public init() {}
    
}

extension StatementDetailCoordinator: StatementDetailCoordinatorProtocol {
    func set(navigation: UINavigationController?) {
        self.navigation = navigation
    }
    
    func start(statement: StatementItem, owner: Person) {
        let viewModel: StatementDetailViewModelProtocol & StatementDetailViewDelegate = StatementDetailViewModel()
        let view: StatementDetailViewProtocol = StatementDetailView()

        viewModel.set(view: view)
        viewModel.set(coordinator: self)
        viewModel.set(statement: statement, owner: owner)
        view.set(delegate: viewModel)
        navigation?.pushViewController(view, animated: true)
    }
    
    func back() {
        self.navigation?.popViewController(animated: true)
    }
}
