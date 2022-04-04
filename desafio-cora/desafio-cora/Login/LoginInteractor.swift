import Foundation

protocol LoginInteracting: AnyObject {
    func doSomething()
}

final class LoginInteractor {

    private let presenter: LoginPresenting

    init(presenter: LoginPresenting) {
        self.presenter = presenter
    }
}

// MARK: - LoginInteracting
extension LoginInteractor: LoginInteracting {
    func doSomething() {
        presenter.displaySomething()
    }
}
