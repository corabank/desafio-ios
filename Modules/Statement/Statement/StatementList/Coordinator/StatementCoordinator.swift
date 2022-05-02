import UIKit

public final class StatementCoordinator {
    
    private var navigation: UINavigationController?
    private let dataSource: StatementDataSourceProtocol = StatementDataSource()
    
    public init() {}
}

extension StatementCoordinator: StatementCoordinatorProtocol {
    public func set(navigation: UINavigationController?) {
        self.navigation = navigation
    }
    
    public func start() {
        let viewModel: StatementViewModelProtocol & StatementViewDelegate = StatementViewModel()
        let view: StatementViewProtocol = StatementView()

        viewModel.set(view: view)
        viewModel.set(coordinator: self)
        viewModel.set(dataSource: dataSource)
        view.set(delegate: viewModel)
        navigation?.pushViewController(view, animated: true)
    }
    
    public func back() {
        navigation?.popViewController(animated: true)
    }
    
    public func goToDetail(item: StatementItem) {
        let coordinator = StatementDetailCoordinator()
        coordinator.set(navigation: navigation)
        coordinator.start(statement: item, owner: dataSource.getUser())
    }
}
