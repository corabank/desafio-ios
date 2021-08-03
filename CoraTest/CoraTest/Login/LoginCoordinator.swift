import UIKit

protocol LoginCoordinating {
    func goToHomeScreen()
}

final class LoginCoordinator: LoginCoordinating {
    private let viewController: UIViewController
    
    init(vc: UIViewController) {
        self.viewController = vc
    }
    
    func goToHomeScreen() {
        let home = HomeFactory.make()
        viewController.present(home, animated: true, completion: nil)
    }
}
