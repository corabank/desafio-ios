import UIKit
import XCoordinator

final class PasswordController: BaseLoginController {
    private let contentView = PasswordView()
    private let router: UnownedRouter<AppRoute>
    private let presenter: PasswordPresenterType

    init(router: UnownedRouter<AppRoute>, presenter: PasswordPresenterType) {
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
            self?.presenter.login(password: $0)
        }
    }
}

extension PasswordController: PasswordControllerType {
    func loggedIn() {
        router.trigger(.invoices)
    }
}
