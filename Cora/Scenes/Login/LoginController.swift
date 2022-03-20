import UIKit
import XCoordinator

final class LoginController: BaseLoginController {
    private let contentView = LoginView()
    private let router: UnownedRouter<AppRoute>
    private let presenter: LoginPresenter

    init(router: UnownedRouter<AppRoute>, presenter: LoginPresenter = LoginPresenter()) {
        self.router = router
        self.presenter = presenter
        super.init()
    }

    override func loadView() {
        view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        keyboardDidAppear = { [weak self] in
            self?.contentView.updateBottomConstraint(keyboardHeight: $0)
        }

        keyboardDidDisappear = { [weak self] in
            self?.contentView.updateBottomConstraint(keyboardHeight: 0)
        }

        contentView.onNextButtonTapped = { [weak self] in
            if self?.presenter.isValidCPF($0) ?? false {
                self?.router.trigger(.password(document: $0))
            }
        }
    }
}
