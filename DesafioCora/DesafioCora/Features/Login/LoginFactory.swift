//
//  LoginFactory.swift
//  DesafioCora
//
//  Created by user205543 on 2/26/22.
//

import Foundation

enum LoginFactory {
    static func make() -> LoginViewController {
        let coordinator = LoginCoordinator()
        let presenter = LoginPresenter(coordinator: coordinator)
        let service = MockedLoginService() //LoginService()
        let interactor = LoginInteractor(service: service, presenter: presenter)
        let viewController = LoginViewController(interactor: interactor)
        
        coordinator.viewController = viewController
        presenter.viewController = viewController
        
        return viewController
    }
}
