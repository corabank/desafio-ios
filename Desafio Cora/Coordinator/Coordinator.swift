//
//  Coordinator.swift
//  Desafio Cora
//
//  Created by João Pedro DTI on 11/05/22.
//

import Foundation
import UIKit

public protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var parent: Coordinator? { get set }
    var navigationController: NavigationController { get set }

    func addChild(_ child: Coordinator)
    func removeChild(_ child: Coordinator?)

    func start()
}

public extension Coordinator {
    // MARK: - Interface
    func addChild(_ child: Coordinator) {
        childCoordinators.append(child)
        child.parent = self
    }

    func removeChild(_ child: Coordinator?) {
        childCoordinators.removeAll { $0 === child }
        child?.parent = nil
    }

    func setRootCoordinator(_ child: Coordinator?) {
        childCoordinators.removeAll()
        parent = nil
    }

    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        navigationController.present(alert, animated: true, completion: nil)
    }
}
