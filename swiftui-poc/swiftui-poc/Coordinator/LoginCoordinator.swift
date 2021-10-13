import UIKit
import SwiftUI

class LoginCoordinator: Coordinator {
    var childCoordinators: [Coordinator]
    var navigationController: UINavigationController
    
    weak var parentCoordinator: AppCoordinator?
    
    init(navigationController: UINavigationController,
         parentCoordinator: AppCoordinator? = nil) {
        self.navigationController = navigationController
        self.childCoordinators = []
        self.parentCoordinator = parentCoordinator
    }
    
    func start() {
        // TODO: REFACTOR TO INJECT WITH DI
        // BEGIN INJECTION
        let dataSource = LocalLoginDataSource(generator: DataGenerator.shared)
        let repository = LoginRepositoryImpl(dataSource: dataSource)
        let useCase = LoginUseCase(repository: repository)
        let viewModel = LoginViewModel(loginUseCase: useCase, coordinator: self)
        // END INJECTION
        
        let view = LoginView(viewModel: viewModel)
        let hosting = UIHostingController(rootView: view)
        self.navigationController.pushViewController(hosting, animated: false)
    }
    
    func didLogInSuccessfully() {
        self.parentCoordinator?.childDidFinish(self)
        self.parentCoordinator?.didFinishLogIn()
    }
    
    func didFailLoggingIn() {
        let alert = UIAlertController(title: "Ooops! Não conseguimos te logar mas é só tentar de novo 😛", message: nil, preferredStyle: .alert)
        self.navigationController.present(alert, animated: true)
        
        Timer.scheduledTimer(withTimeInterval: 2.5, repeats: false) { _ in alert.dismiss(animated: true) }
    }
}
