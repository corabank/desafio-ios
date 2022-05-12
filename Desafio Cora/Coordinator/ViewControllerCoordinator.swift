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
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let vc = ViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
}
