import UIKit

protocol SignInCoordinating: AnyObject {
    func coordinateToPasswordScene()
}

final class SignInCoordinator {
    weak var viewController: UIViewController?
}

extension SignInCoordinator: SignInCoordinating {
    func coordinateToPasswordScene() {
        let scene = PasswordFactory.make()
        viewController?.show(scene, sender: nil)
    }
}
