import Foundation

protocol PasswordPresenting: AnyObject {
    var viewController: PasswordDisplaying? { get set }
    func presentExtractScene()
    func presentLostPassword()
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
    func presentExtractScene() {
        coordinator.coordinateToExtractScene()
    }
    
    func presentLostPassword() {
        coordinator.coordinateToLostPassword()
    }
}
