import Foundation
import UIKit
@testable import swiftui_poc

class MockLoginCoordinator: LoginCoordinator {
    init() {
        super.init(navigationController: UINavigationController())
        self.childCoordinators = []
        self.navigationController = UINavigationController()
    }
    
    override func start() {
        fatalError("this is a mocked coordinator")
    }
}
