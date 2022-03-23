import XCoordinator

@testable import Cora

final class AppCoordinatorSpy: AppCoordinator {

    private(set) var lastRouteTriggered: AppRoute?

    override func prepareTransition(for route: AppRoute) -> NavigationTransition {
        lastRouteTriggered = route
        return super.prepareTransition(for: route)
    }
}
