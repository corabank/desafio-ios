//
//  AppDelegate.swift
//  cora
//
//  Created by Lucas Silveira on 16/04/21.
//

import UIKit
import Swinject

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var coordinator: MainCoordinator?

    lazy var window: UIWindow? = {
        let instance = UIWindow(frame: UIScreen.main.bounds)
        instance.backgroundColor = #colorLiteral(red: 0.09803921569, green: 0.1725490196, blue: 0.2274509804, alpha: 1)

        return instance
    }()

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        Facade.injectDataSources()
        Facade.injectRepositories()
        Facade.injectUseCases()
        
        let navigationController = UINavigationController()
        navigationController.viewControllers = []

        window?.rootViewController = navigationController

        coordinator = MainCoordinator(withNavigation: navigationController)
        window?.makeKeyAndVisible()
        coordinator?.start()

        return true
    }
}
