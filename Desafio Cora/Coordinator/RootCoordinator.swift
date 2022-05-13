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
    private weak var window: UIWindow?

    public init(window: UIWindow?) {
        self.window = window
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()

        super.init()
    }

    public func start() {
        navigationController.delegate = self
        let introCoordinator = IntroCoordinator(navigationController: navigationController)
        addChild(introCoordinator)
        introCoordinator.start()
    }

    public func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        // Read the view controller we’re moving from.
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else {
            return
        }

        // Check whether our view controller array already contains that view controller. If it does it means we’re pushing a different view controller on top rather than popping it, so exit.
        if navigationController.viewControllers.contains(fromViewController) {
            return
        }

        // We’re still here – it means we’re popping the view controller, so we can check whether it’s a buy view controller
        if let buyViewController = fromViewController as? ViewController {
            // We're popping a buy view controller; end its coordinator
            removeChild(buyViewController.coordinator)
        }
    }
}
