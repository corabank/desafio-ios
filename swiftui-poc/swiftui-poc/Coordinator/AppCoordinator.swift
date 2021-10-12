import UIKit
import SwiftUI

class AppCoordinator: Coordinator {
    var childCoordinators: [Coordinator]
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.childCoordinators = []
    }
    
    func start() {
        let view = LoginView()
        let hosting = UIHostingController(rootView: view)
        self.navigationController.pushViewController(hosting, animated: false)
    }
    
//    func purchase(toast: ToastItem) {
//        // TODO: REFACTOR TO INJECT WITH DI
//        // BEGIN INJECTION
//        self.manager.interceptor = self.interceptor
//        let checkoutRemote = ApiCheckoutDataSource(manager: manager)
//        let checkoutRepository = CheckoutRepositoryImpl(checkoutDataSource: checkoutRemote)
//        let checkoutUseCase = CheckoutUseCase(repository: checkoutRepository)
//        // END INJECTION
//
//        let view = NavigationView {
//            let viewModel = CreditCardViewModel(initialState: .input,
//                                                coordinator: self,
//                                                toast: toast,
//                                                checkoutUseCase: checkoutUseCase)
//            CreditCardView(viewModel: viewModel)
//        }
//        let viewController = UIHostingController(rootView: view)
//        self.navigationController.present(viewController, animated: true)
//    }
//
//    func didProcessCheckout(withMessage message: String) {
//        self.navigationController.presentedViewController?.dismiss(animated: true)
//
//        let alert = UIAlertController(title: message, message: nil, preferredStyle: .alert)
//        self.navigationController.present(alert, animated: true)
//        Timer.scheduledTimer(withTimeInterval: 2.5, repeats: false, block: { _ in alert.dismiss(animated: true) })
//    }
}
