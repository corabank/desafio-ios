import UIKit

final class CPFFormCoordinator {
    
    private var navigation: UINavigationController?
    
    public init() {}
}

extension CPFFormCoordinator: CPFFormCoordinatorProtocol {
    public func set(navigation: UINavigationController?) {
        self.navigation = navigation
    }
    
    public func start() {
        let formViewModel: CPFFormViewModelProtocol & CPFFormViewDelegate = CPFFormViewModel()
        let formView: CPFFormViewProtocol = CPFFormView()

        formViewModel.set(view: formView)
        formViewModel.set(coordinator: self)
        formView.set(delegate: formViewModel)
        navigation?.pushViewController(formView, animated: true)
    }
    
    public func login() {
        let passCoordinator: PassFormCoordinatorProtocol = PassFormCoordinator()
        passCoordinator.set(navigation: self.navigation)
        passCoordinator.start()
    }
    
    public func back() {
        navigation?.popViewController(animated: true)
    }
}
