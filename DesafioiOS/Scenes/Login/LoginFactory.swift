//
//  LoginFactory.swift
//  DesafioiOS
//
//  Created by Allana Castenharo Santamaria on 28/05/22.
//

import UIKit

public struct LoginFactory {
    static func make(screenType: LoginInteractor.ScreenType) -> UIViewController {
        let coordinator = LoginCoordinator()
        let presenter = LoginPresenter(coordinator: coordinator)
        let interactor = LoginInteractor(screenType: screenType, presenter: presenter)
        let viewController = LoginViewController(interactor: interactor)
        
        presenter.viewController = viewController
        coordinator.viewController = viewController
        
        return viewController
    }
}
