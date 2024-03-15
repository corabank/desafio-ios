//
//  AppNavigation.swift
//  app
//
//  Created by João Gabriel Dourado Cervo on 14/03/24.
//

import UIKit
import Core
import Network
import Login

class AppNavigation: NavigationCoordinator, ExternalNavigationService {
    var navigationController: UINavigationController
    var container: DIContainerService
               
    init(navigationController: UINavigationController, container: DIContainerService) {
        self.navigationController = navigationController
        self.container = container
    }
    
    func openLoginViewController() {
        let loginNavigationService = container.resolve(type: LoginCoordinator.self)!
        let viewController = loginNavigationService.container.resolve(type: PresentableLoginView.self)!
        navigationController.show(viewController.toPresent(), sender: nil)
    }
    
    func openExtractViewController() {
        
    }
    
    func openDetailsViewController() {
        
    }
    
    func popToRootViewController(animated: Bool) {
        navigationController.popToRootViewController(animated: animated)
    }

}
