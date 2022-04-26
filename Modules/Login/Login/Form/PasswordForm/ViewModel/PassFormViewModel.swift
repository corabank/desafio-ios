import Foundation

final class PassFormViewModel {
    private var view: PassFormViewProtocol?
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
    func inputCPF() {
        // change view
    }
    
    func inputPassword() {
        coordinator?.login()
    }
}
