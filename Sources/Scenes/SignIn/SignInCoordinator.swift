import UIKit

protocol SignInCoordinating: AnyObject {
    func coordinateToPasswordScene()
}

final class SignInCoordinator {
    weak var viewController: UIViewController?
}

extension SignInCoordinator: SignInCoordinating {
    func coordinateToPasswordScene() {
        
    }
}
