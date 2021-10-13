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
        let dataSource = LocalTransactionDataSource(manager: LocalFileReader.shared)
        let repository = TransactionRepositoryImpl(dataSource: dataSource)
        let useCase = FetchTransactionsUseCase(repository: repository)
        let viewModel = TransactionListViewModel(fetchTransactionsUseCase: useCase,
                                                 coordinator: self)
        // END INJECTION
        
        let view = TransactionListView(viewModel: viewModel)
        let hosting = UIHostingController(rootView: view)
        self.navigationController.pushViewController(hosting, animated: false)
    }
}
