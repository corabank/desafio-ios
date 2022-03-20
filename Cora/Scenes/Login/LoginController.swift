import UIKit
import XCoordinator

final class LoginController: UIViewController {
    private lazy var contentView = LoginView(navBarHeight: 58)
    private let router: UnownedRouter<AppRoute>

    override var preferredStatusBarStyle: UIStatusBarStyle { .darkContent }

    init(router: UnownedRouter<AppRoute>) {
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    @objc
    private func onBackButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}
