import UIKit

public final class CPFFormCoordinator {
    
    private var navigation: UINavigationController?
    
    private let formViewModel: CPFFormViewModelProtocol & CPFFormViewDelegate = CPFFormViewModel()
    private let formView: CPFFormViewProtocol = CPFFormView()
    
    public init() {}
}

extension CPFFormCoordinator: CPFFormCoordinatorProtocol {
    public func set(navigation: UINavigationController?) {
        self.navigation = navigation
    }
    
    public func start() {
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
}
