import UIKit
import Foundation
import Login

class AppCoordinator {
    private let window: UIWindow
    private let navigator: UINavigationController
    
    init(window: UIWindow) {
        self.window = window
        self.navigator = UINavigationController()
    }
    
    func start() {
        self.window.rootViewController = self.navigator
        self.window.makeKeyAndVisible()
    }
    
    func goToMainView() {
        let loginCoordinator: LoginCoordinatorProtocol = LoginCoordinator()
        loginCoordinator.set(navigation: self.navigator)
        loginCoordinator.start()
    }
}
