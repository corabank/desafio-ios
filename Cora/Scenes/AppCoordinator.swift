import XCoordinator

enum AppRoute: Route {
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
        case .password:
            return .none()
        case .invoices:
            return .none()
        }
    }
}
