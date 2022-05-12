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
    var navigationController: UINavigationController { get set}

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
}

