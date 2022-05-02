final class PassFormViewModel {
    private weak var view: PassFormViewProtocol?
    private var coordinator: PassFormCoordinatorProtocol?
    
    init() {}
}

extension PassFormViewModel: PassFormViewModelProtocol {
    func set(coordinator: PassFormCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
    func set(view: PassFormViewProtocol) {
        self.view = view
    }
}

extension PassFormViewModel: PassFormViewDelegate {
    func inputPassword(_ value: String) {
        coordinator?.goToStatement()
    }
    
    func tapBack() {
        coordinator?.back()
    }
}
