protocol PasswordInteracting: AnyObject {
    func didChangeText(to newText: String)
    func performNextStep()
    func tooglePasswordVisibility()
}

final class PasswordInteractor {
    private let presenter: PasswordPresenting

    private var isPasswordVisible = false
    
    init(presenter: PasswordPresenting) {
        self.presenter = presenter
    }
}

extension PasswordInteractor: PasswordInteracting {
    func didChangeText(to newText: String) {
        let isNextStepEnabled =  newText.count > 0
        presenter.presentNextStepButton(isEnabled: isNextStepEnabled)
    }
    
    func performNextStep() {
        presenter.presentBankStatementScene()
    }
    
    func tooglePasswordVisibility() {
        isPasswordVisible.toggle()
        presenter.presentPassword(isVisible: isPasswordVisible)
    }
}
