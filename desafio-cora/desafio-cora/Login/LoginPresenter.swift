import Foundation

protocol LoginPresenting: AnyObject {
    var viewController: LoginDisplaying? { get set }
    func presentPasswordScene()
}

final class LoginPresenter {

    private let coordinator: LoginCoordinating
    weak var viewController: LoginDisplaying?

    init(coordinator: LoginCoordinating) {
        self.coordinator = coordinator
    }
}

// MARK: - LoginPresenting
extension LoginPresenter: LoginPresenting {
    func presentPasswordScene() {
        coordinator.coordinateToPasswordScene()
    }
}
