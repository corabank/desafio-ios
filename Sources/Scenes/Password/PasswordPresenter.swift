import class UIKit.UIImage

protocol PasswordPresenting: AnyObject {
    func presentBankStatementScene()
    func presentNextStepButton(isEnabled: Bool)
    func presentPassword(isVisible: Bool)
}

final class PasswordPresenter {
    private let coordinator: PasswordCoordinating
    weak var viewController: PasswordDisplaying?

    init(coordinator: PasswordCoordinating ) {
        self.coordinator = coordinator
    }
}

extension PasswordPresenter: PasswordPresenting {
    func presentBankStatementScene() {
        coordinator.coordinateToBankStatement()
    }
    
    func presentNextStepButton(isEnabled: Bool) {
        viewController?.displayNextStepButton(isEnabled: isEnabled)
    }
    
    func presentPassword(isVisible: Bool) {
        let appropriateIcon: UIImage = isVisible ? Images.icEyeOpen.image : Images.icEyeHidden.image
        viewController?.displayPassword(isVisible: isVisible, fieldImage: appropriateIcon)
    }
}
