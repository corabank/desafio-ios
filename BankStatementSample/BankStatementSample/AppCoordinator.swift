import UIKit
import Foundation
import Login
import ServiceLocator

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
    
    func goToHome() {
        // TODO - maybe add some handling for login
    }
}
