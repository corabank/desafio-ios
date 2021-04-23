//
//  MainCoordinator.swift
//  cora
//
//  Created by Lucas Silveira on 22/04/21.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {
    var navigationController: UINavigationController
    var children: [Coordinator] = []
    var shouldAnimate: Bool = true
    
    required init(withNavigation navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        login()
    }
}

extension MainCoordinator {
    func login() {
        let useCase = container.resolve(LoginUseCaseProtocol.self)!
        let loginViewModel = LoginViewModel(useCase: useCase)
        let loginViewController = LoginViewController()
        
        loginViewController.viewModel = loginViewModel
        loginViewController.delegate = self
        self.navigationController.viewControllers = [loginViewController]
    }
    
    func listOrders(orderID: UUID? = nil) {
        let useCase = container.resolve(OrdersUseCaseProtocol.self)!
        let viewModel = OrdersViewModel(useCase: useCase)
        let ordersViewController = OrdersViewController()
        ordersViewController.viewModel = viewModel
        ordersViewController.delegate = self
        ordersViewController.view.layer.opacity = 0
        ordersViewController.transitioningDelegate = navigationController
        
        ordersViewController.modalPresentationStyle = .custom
        navigationController.present(ordersViewController, animated: shouldAnimate, completion: nil)
        UIView.transition(with: ordersViewController.view,
                          duration: 1,
                          options: .curveEaseInOut,
                          animations: {
                            ordersViewController.view.layer.opacity = 1
        }, completion: nil)
    }
    
    func orderDetail(order: Order) {
        let viewModel = OrderDetailViewModel(order: order)
        let orderDetailViewController = OrderDetailViewcontroller()
        orderDetailViewController.viewModel = viewModel
        orderDetailViewController.delegate = self
        orderDetailViewController.modalPresentationStyle = .overCurrentContext
        
        navigationController.dismiss(animated: true) {
            self.navigationController.present(orderDetailViewController, animated: true, completion: nil)
        }
    }
}

extension MainCoordinator: LoginViewControllerDelegate {
    func authenticated() {
        self.listOrders()
    }
}

extension MainCoordinator: OrdersViewControllerDelegate {
    func showDetail(order: Order) {
        self.orderDetail(order: order)
    }
}

extension MainCoordinator: OrderDetailViewcontrollerDelegate {
    func back(orderID: UUID) {
        navigationController.dismiss(animated: false) {
            self.shouldAnimate = true
            self.listOrders(orderID: orderID)
        }
    }
}
