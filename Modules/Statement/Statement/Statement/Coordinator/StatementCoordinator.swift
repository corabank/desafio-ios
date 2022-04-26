import UIKit

public final class StatementCoordinator {
    
    private var navigation: UINavigationController?
    
    private let formViewModel: StatementViewModelProtocol & StatementViewDelegate = StatementViewModel()
    private let formView: StatementViewProtocol = StatementView()
    
    public init() {}
}

extension StatementCoordinator: StatementCoordinatorProtocol {
    public func set(navigation: UINavigationController?) {
        self.navigation = navigation
    }
    
    public func start() {
        formViewModel.set(view: formView)
        formViewModel.set(coordinator: self)
        formView.set(delegate: formViewModel)
        navigation?.pushViewController(formView, animated: true)
    }
}
