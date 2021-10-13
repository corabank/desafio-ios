import UIKit
import SwiftUI

class TransactionCoordinator: Coordinator {
    var childCoordinators: [Coordinator]
    var navigationController: UINavigationController
    
    weak var parentCoordinator: Coordinator?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.childCoordinators = []
    }
    
    func start() {
        // TODO: REFACTOR TO INJECT WITH DI
        // BEGIN INJECTION
        let viewModel = TransactionListViewModel()
        // END INJECTION
        
        let view = TransactionListView(viewModel: viewModel)
        let hosting = UIHostingController(rootView: view)
        self.navigationController.pushViewController(hosting, animated: false)
    }
}
