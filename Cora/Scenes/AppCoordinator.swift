import XCoordinator

enum AppRoute: Route, Equatable {
    case home
    case login
    case password(document: String)
    case invoices
}

class AppCoordinator: NavigationCoordinator<AppRoute> {
    init() {
        super.init(initialRoute: .home)
    }

    override func prepareTransition(for route: AppRoute) -> NavigationTransition {
        switch route {
        case .home:
            return .push(HomeController(router: unownedRouter))
        case .login:
            return .push(LoginController(router: unownedRouter))
        case let .password(document):
            let presenter = PasswordPresenter(document: document)
            let controller = PasswordController(router: unownedRouter, presenter: presenter)
            presenter.controller = controller
            return .push(controller)
        case .invoices:
                let presenter = InvoicePresenter()
                let controller = InvoiceController(presenter: presenter)
                presenter.controller = controller
                return .set([HomeController(router: unownedRouter), controller])
        }
    }
}
