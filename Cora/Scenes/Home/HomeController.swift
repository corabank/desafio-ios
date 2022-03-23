import UIKit
import XCoordinator

final class HomeController: UIViewController {
    private let contentView: HomeViewType
    private let router: UnownedRouter<AppRoute>

    init(router: UnownedRouter<AppRoute>,
         contentView: HomeViewType = HomeView()) {
        self.router = router
        self.contentView = contentView
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
        bindActions()
    }

    private func bindActions() {
        contentView.didTapLogin = { [weak self] in
            self?.router.trigger(.login)
        }
    }
}
