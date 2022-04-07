import Foundation

protocol PasswordInteracting: AnyObject {
    func doSomething()
}

final class PasswordInteractor {
    private let presenter: PasswordPresenting

    init(presenter: PasswordPresenting) {
        self.presenter = presenter
    }
}

// MARK: - PasswordInteracting
extension PasswordInteractor: PasswordInteracting {
    func doSomething() {
        presenter.displaySomething()
    }
}
