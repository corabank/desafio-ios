import UIKit
import Statement

final class PassFormCoordinator {
    
    private var navigation: UINavigationController?
    
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
        let formViewModel: PassFormViewModelProtocol & PassFormViewDelegate = PassFormViewModel()
        let formView: PassFormViewProtocol = PassFormView()

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
