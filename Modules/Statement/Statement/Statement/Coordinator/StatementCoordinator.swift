import UIKit

public final class StatementCoordinator {
    
    private var navigation: UINavigationController?
    
    private let viewModel: StatementViewModelProtocol & StatementViewDelegate = StatementViewModel()
    private let dataSource: StatementDataSourceProtocol = StatementDataSource()
    private let view: StatementViewProtocol = StatementView()
    
    public init() {}
}

extension StatementCoordinator: StatementCoordinatorProtocol {
    public func set(navigation: UINavigationController?) {
        self.navigation = navigation
    }
    
    public func start() {
        viewModel.set(view: view)
        viewModel.set(coordinator: self)
        view.set(delegate: viewModel)
        navigation?.pushViewController(view, animated: true)
    }
}
