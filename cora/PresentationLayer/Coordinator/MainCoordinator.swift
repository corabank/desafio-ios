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
    
    func listOrders() {
        let useCase = container.resolve(OrdersUseCaseProtocol.self)!
        let viewModel = OrdersViewModel(useCase: useCase)
        let ordersViewController = OrdersViewController()

        ordersViewController.viewModel = viewModel
        ordersViewController.delegate = self
        ordersViewController.view.layer.opacity = 0
        ordersViewController.beginAppearanceTransition(true, animated: true)

        navigationController.addChild(ordersViewController)
        navigationController.view.addSubview(ordersViewController.view)

        UIView.transition(
            with: ordersViewController.view,
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
        
        self.navigationController.present(orderDetailViewController, animated: true, completion: nil)
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
    func back() {
        navigationController.dismiss(animated: true, completion: nil)
    }
}
