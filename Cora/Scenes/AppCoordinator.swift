import XCoordinator

enum AppRoute: Route {
    case home
    case login
    case password
    case invoices
}

class AppCoordinator: NavigationCoordinator<AppRoute> {
    init() {
        super.init(initialRoute: .home)
    }

    override func prepareTransition(for route: AppRoute) -> NavigationTransition {
        let home = HomeController()
        return .push(home)
    }
}
