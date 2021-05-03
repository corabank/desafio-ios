//
//  Coordinator.swift
//  cora
//
//  Created by Lucas Silveira on 16/04/21.
//

import UIKit

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get set }
    var children: [Coordinator] { get set }

    init(withNavigation navigationController: UINavigationController)
    func start()
}
