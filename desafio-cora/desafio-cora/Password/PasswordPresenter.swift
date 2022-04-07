import Foundation

protocol PasswordPresenting: AnyObject {
    var viewController: PasswordDisplaying? { get set }
    func displaySomething()
}

final class PasswordPresenter {
    private let coordinator: PasswordCoordinating
    weak var viewController: PasswordDisplaying?

    init(coordinator: PasswordCoordinating) {
        self.coordinator = coordinator
    }
}

// MARK: - PasswordPresenting
extension PasswordPresenter: PasswordPresenting {
    func displaySomething() {
        viewController?.displaySomething()
    }
}
