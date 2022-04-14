import Foundation

protocol PasswordPresenting: AnyObject {
    var viewController: PasswordDisplaying? { get set }
    func didNextStep(action: PasswordAction)
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
    func didNextStep(action: PasswordAction) {
        coordinator.perform(action: action)
    }
}
