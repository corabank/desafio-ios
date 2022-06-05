//
//  LoginCoordinator.swift
//  DesafioiOS
//
//  Created by Allana Castenharo Santamaria on 28/05/22.
//

import UIKit

protocol LoginCoordinating: AnyObject {
    func showPassword()
    func showExtract()
}

final class LoginCoordinator {
    weak var viewController: UIViewController?
}

extension LoginCoordinator: LoginCoordinating {
    func showPassword() {
        let controller = LoginFactory.make(screenType: .password)
        viewController?.navigationController?.pushViewController(controller, animated: true)
    }
    
    func showExtract() {
        let controller = ExtractFactory.make()
        viewController?.navigationController?.pushViewController(controller, animated: true)
    }
}

