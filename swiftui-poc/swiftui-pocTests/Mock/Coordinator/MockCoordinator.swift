import Foundation
import UIKit
@testable import swiftui_poc

class MockCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    
    var navigationController: UINavigationController = UINavigationController()
    
    func start() {
        fatalError("this is a mocked coordinator")
    }
    
    func startChild(_ child: Coordinator) {
        childCoordinators.append(child)
    }
}
