//
//  File.swift
//  
//
//  Created by João Gabriel Dourado Cervo on 14/03/24.
//

import UIKit
import Core

public protocol LoginNavigationService {
    var container: DIContainerService { get set }
    var navigationController: UINavigationController? { get set }
    
    func openLoginViewController()
    func openExtractViewController()
}

public class LoginNavigation: LoginNavigationService {
    public var container: DIContainerService
    public var navigationController: UINavigationController?
    
    public init(container: DIContainerService,
                navigationController: UINavigationController? = nil) {
        self.container = container
        self.navigationController = navigationController
        registerViewControllers()
    }
    
    private func registerViewControllers() {
        container.register(type: PresentableLoginView.self) { container in
            LoginViewController(
                viewModel: container.resolve(type: LoginViewModelProtocol.self)!,
                navigationService: container.resolve(type: LoginNavigationService.self)!
            )
        }
    }
    
    public func openLoginViewController() {
        let viewController = container.resolve(type: PresentableLoginView.self)!
        navigationController?.show(viewController.toPresent(), sender: nil)
    }
    
    public func openExtractViewController() {
        let viewController = container.resolve(type: PresentableExtractView.self)!
    }
}
