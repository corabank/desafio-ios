import Foundation

final class CPFFormViewModel {
    private weak var view: CPFFormViewProtocol?
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
    func tapBack() {
        coordinator?.back()
    }
    
    func inputCPF(_ value: String) {
        coordinator?.login()
    }
}
