protocol SignInInteracting: AnyObject {
    func didChangeText(to newText: String)
    func performNextStep()
}

final class SignInInteractor {
    private let presenter: SignInPresenting

    init(presenter: SignInPresenting) {
        self.presenter = presenter
    }
}

extension SignInInteractor: SignInInteracting {
    func didChangeText(to newText: String) {
        presenter.presentMaskedField(basedOn: newText)
    }
    
    func performNextStep() {
        presenter.presentPasswordScene()
    }
}
