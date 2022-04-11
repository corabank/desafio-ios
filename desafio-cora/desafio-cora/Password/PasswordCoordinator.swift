import UIKit

protocol PasswordCoordinating: AnyObject {
    var viewController: UIViewController? { get set }
    func coordinateToExtractScene()
    func coordinateToLostPassword()
}

final class PasswordCoordinator {
    weak var viewController: UIViewController?
}

// MARK: - PasswordCoordinating
extension PasswordCoordinator: PasswordCoordinating {
    func coordinateToExtractScene() {
        let vc = ExtractFactory.make()
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func coordinateToLostPassword() {
        print("Perdi minha senha")
    }
}
