//
//  RootCoordinator.swift
//  Desafio Cora
//
//  Created by João Pedro DTI on 11/05/22.
//

import Foundation
import UIKit

public class RootCoordinator: NSObject, Coordinator, UINavigationControllerDelegate {

    // MARK: - Properties
    public var navigationController: NavigationController = NavigationController()
    public var rootViewController: UIViewController { navigationController }
    public var childCoordinators = [Coordinator]()
    public var parent: Coordinator?
    private var networkServices: NetworkCoordinator
    private weak var window: UIWindow?

    public init(window: UIWindow?) {
        networkServices = NetworkCoordinator(navigationController: navigationController)
        self.window = window
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()

        super.init()
    }

    public func start() {
        navigationController.delegate = self
        let introCoordinator = IntroCoordinator(navigationController: navigationController, networkServices: networkServices)
        addChild(introCoordinator)
        introCoordinator.start()
    }

    public func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else {
            return
        }
        if navigationController.viewControllers.contains(fromViewController) {
            return
        }
        if let buyViewController = fromViewController as? LoginViewController {
            removeChild(buyViewController.coordinator)
        }
    }
}
