//
//  File.swift
//  
//
//  Created by João Gabriel Dourado Cervo on 14/03/24.
//

import UIKit
import Core

public protocol LoginCoordinator {
    var container: DIContainerService { get set }
    var navigationController: UINavigationController? { get set }
    
    func openLoginViewController()
    func openExtractViewController()
    func openCPFScreen()
    func openPasswordScreen(viewModel: LoginViewModelProtocol)
}

//MARK: - implementation

public class LoginNavigation: LoginCoordinator {
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
            IntroViewController(navigationService: container.resolve(type: LoginCoordinator.self)!)
        }
    }
    
    public func openLoginViewController() {
        let viewController = container.resolve(type: PresentableLoginView.self)!
        navigationController?.show(viewController.toPresent(), sender: nil)
    }
    
    public func openCPFScreen() {
        navigationController?.isNavigationBarHidden = false
        
        let cpfViewController = LoginCPFViewController(
            viewModel: container.resolve(type: LoginViewModelProtocol.self)!,
            navigationService: container.resolve(type: LoginCoordinator.self)!
        )
        navigationController?.pushViewController(cpfViewController, animated: true)
    }
    
    public func openPasswordScreen(viewModel: LoginViewModelProtocol) {
        let passViewController = LoginPasswordViewController()
        navigationController?.pushViewController(passViewController, animated: true)
    }
    
    public func openExtractViewController() {
        let viewController = container.resolve(type: PresentableExtractView.self)!
    }
}
