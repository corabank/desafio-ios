//
//  ViewControllerCoordinator.swift
//  Desafio Cora
//
//  Created by João Pedro DTI on 11/05/22.
//

import Foundation
import UIKit

class ViewControllerCoordinator: NSObject, Coordinator {
    var childCoordinators = [Coordinator]()
    weak var parent: Coordinator?
    var navigationController: NavigationController
    private var networkServices: NetworkCoordinator?

    init(navigationController: NavigationController, networkServices: NetworkCoordinator?) {
        self.navigationController = navigationController
        self.networkServices = networkServices
    }

    func start() {
        let viewC = ViewController()
        viewC.coordinator = self
        navigationController.pushViewController(viewC, animated: true)
    }
}
