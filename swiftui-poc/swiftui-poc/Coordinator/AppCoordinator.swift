import UIKit
import SwiftUI
import UIKit

class AppCoordinator: Coordinator {
    var childCoordinators: [Coordinator]
    var navigationController: UINavigationController
    
    weak var window: UIWindow?
    
    init(window: UIWindow,
         navigationController: UINavigationController) {
        self.window = window
        self.navigationController = navigationController
        self.childCoordinators = []
    }
    
    func start() {
        let child = LoginCoordinator(navigationController: self.navigationController,
                                     parentCoordinator: self)
        self.startChild(child)
        
        self.window?.rootViewController = self.navigationController
        self.window?.makeKeyAndVisible()
    }
    
    func didFinishLogIn() {
        UIView.transition(with: self.window!, duration: 0.5, options: [.transitionFlipFromLeft]) {
            
            self.navigationController = UINavigationController()
            
            let child = TransactionCoordinator(navigationController: self.navigationController)
            self.startChild(child)
            
            self.window?.rootViewController = self.navigationController
        }
    }
}
