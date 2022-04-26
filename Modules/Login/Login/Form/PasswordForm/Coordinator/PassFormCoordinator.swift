import UIKit

public final class PassFormCoordinator {
    
    private var navigation: UINavigationController?
    
    private let formViewModel: PassFormViewModelProtocol & PassFormViewDelegate = PassFormViewModel()
    private let formView: PassFormViewProtocol = PassFormView()
    
    public init() {}
}

extension PassFormCoordinator: PassFormCoordinatorProtocol {
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
        print("login app =>")
    }
}
