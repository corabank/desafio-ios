import UIKit
import Statement

final class PassFormCoordinator {
    
    private var navigation: UINavigationController?
    
    private let formViewModel: PassFormViewModelProtocol & PassFormViewDelegate = PassFormViewModel()
    private let formView: PassFormViewProtocol = PassFormView()
    
    public init() {}
}

extension PassFormCoordinator: PassFormCoordinatorProtocol {
    func back() {
        self.navigation?.popViewController(animated: true)
    }
    
    public func set(navigation: UINavigationController?) {
        self.navigation = navigation
    }
    
    public func start() {
        formViewModel.set(view: formView)
        formViewModel.set(coordinator: self)
        formView.set(delegate: formViewModel)
        navigation?.pushViewController(formView, animated: true)
    }
    
    public func goToStatement() {
        let passCoordinator: StatementCoordinatorProtocol = StatementCoordinator()
        passCoordinator.set(navigation: self.navigation)
        passCoordinator.start()
    }
}
