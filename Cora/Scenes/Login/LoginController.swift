import UIKit
import XCoordinator

final class LoginController: UIViewController {
    private let contentView = LoginView()
    private let router: UnownedRouter<AppRoute>

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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavBar()
    }

    override func viewWillDisappear(_ animated: Bool) {
        clearNavBar()
        super.viewWillDisappear(animated)
    }

    private func setupNavBar() {
        navigationItem.title = L10n.Login.title
        navigationController?.navigationBar.backgroundColor = .gray4
        navigationController?.navigationBar.tintColor = .mainCora

        let textAttributes = [NSAttributedString.Key.font: UIFont.body2,
                              NSAttributedString.Key.foregroundColor: UIColor.gray1]
        navigationController?.navigationBar.titleTextAttributes = textAttributes

        let customBackButton = UIBarButtonItem(image: Images.iconArrowLeft.image,
                                               style: .plain,
                                               target: self,
                                               action: #selector(onBackButtonTapped))
        navigationItem.leftBarButtonItem = customBackButton
    }

    private func clearNavBar() {
        navigationController?.navigationBar.backgroundColor = .clear
    }

    @objc
    private func onBackButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}
