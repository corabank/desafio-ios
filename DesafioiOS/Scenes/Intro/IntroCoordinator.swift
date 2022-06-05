//
//  IntroCoordinator.swift
//  DesafioiOS
//
//  Created by Allana Castenharo Santamaria on 27/05/22.
//

import UIKit

protocol IntroCoordinating: AnyObject {
    func showLogin()
}

final class IntroCoordinator {
    weak var viewController: UIViewController?
}

extension IntroCoordinator: IntroCoordinating {
    func showLogin() {
        let controller = LoginFactory.make(screenType: .cpf)
        viewController?.navigationController?.pushViewController(controller, animated: true)
    }
}
