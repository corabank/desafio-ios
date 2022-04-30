import UIKit

final class StatementDetailCoordinator {

    private var navigation: UINavigationController?
    
    private let viewModel: StatementDetailViewModelProtocol & StatementDetailViewDelegate = StatementDetailViewModel()
    private let view: StatementDetailViewProtocol = StatementDetailView()
    
    public init() {}
}

extension StatementDetailCoordinator: StatementDetailCoordinatorProtocol {
    func set(navigation: UINavigationController?) {
        self.navigation = navigation
    }
    
    func start(statement: StatementItem) {
        viewModel.set(view: view)
        viewModel.set(coordinator: self)
        viewModel.set(statement: statement)
        view.set(delegate: viewModel)
        navigation?.pushViewController(view, animated: true)
    }
    
    func back() {
        self.navigation?.popViewController(animated: true)
    }
}
