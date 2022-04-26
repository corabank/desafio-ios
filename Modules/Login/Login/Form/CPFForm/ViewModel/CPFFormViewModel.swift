import Foundation

final class CPFFormViewModel {
    private var view: CPFFormViewProtocol?
    private var coordinator: CPFFormCoordinatorProtocol?
    
    init() {}
}

extension CPFFormViewModel: CPFFormViewModelProtocol {
    func set(coordinator: CPFFormCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
    func set(view: CPFFormViewProtocol) {
        self.view = view
    }
}

extension CPFFormViewModel: CPFFormViewDelegate {
    func inputCPF() {
        coordinator?.login()
    }
}
