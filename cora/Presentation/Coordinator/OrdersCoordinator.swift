//
//  OrdersCoordinator.swift
//  cora
//
//  Created by Lucas Silveira on 16/04/21.
//

import UIKit

class OrdersCoordinator: Coordinator {
    var user: User?
    var shouldAnimate: Bool = true
    var childrens: [Coordinator] = []
    private let navigationController: UINavigationController

    required init(withNavigation navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let dataSource = OrdersDataSource()
        let repository = OrdersRepository(ordersDataSource: dataSource)
        let useCase = OrdersUseCase(repository: repository)
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
}

extension OrdersCoordinator: OrdersViewControllerDelegate {
    func showDetail(order: Order) {
        let orderDetailViewController = OrderDetailViewcontroller()
        orderDetailViewController.viewModel = OrderDetailViewModel(order: order)
        orderDetailViewController.delegate = self
        orderDetailViewController.transitioningDelegate = navigationController
        orderDetailViewController.modalPresentationStyle = .custom
        navigationController.dismiss(animated: false) {
            self.navigationController.present(orderDetailViewController, animated: false)
        }
    }
}

extension OrdersCoordinator: OrderDetailViewcontrollerDelegate {
    func back() {
        navigationController.dismiss(animated: false) {
            self.shouldAnimate = false
            self.start()
        }
    }
}
