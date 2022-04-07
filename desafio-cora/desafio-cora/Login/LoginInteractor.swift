import Foundation

protocol LoginInteracting: AnyObject {
    func passwordScene()
}

final class LoginInteractor {

    private let presenter: LoginPresenting

    init(presenter: LoginPresenting) {
        self.presenter = presenter
    }
}

// MARK: - LoginInteracting
extension LoginInteractor: LoginInteracting {
    func passwordScene() {
        presenter.presentPasswordScene()
    }
}
