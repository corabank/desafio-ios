//
//  File.swift
//  
//
//  Created by João Gabriel Dourado Cervo on 16/03/24.
//

import UIKit
import Core

public protocol ExtractCoordinator {
    var container: DIContainerService { get set }
    var navigationController: UINavigationController? { get set }
    
    func openExtractScreen()
}

//MARK: - implementation

public class ExtractNavigator: ExtractCoordinator {
    public var container: DIContainerService
    public var navigationController: UINavigationController?
    
    public init(container: DIContainerService,
                navigationController: UINavigationController? = nil) {
        self.container = container
        self.navigationController = navigationController
        registerViewControllers()
    }
    
    private func registerViewControllers() {
        container.register(type: PresentableExtractView.self) { container in
            ExtractViewController(navigationService: container.resolve(type: ExtractCoordinator.self)!)
        }
    }
    
    public func openExtractScreen() {
        let viewController = container.resolve(type: PresentableExtractView.self)!
        navigationController?.setViewControllers([viewController.toPresent()], animated: true)
    }
}
