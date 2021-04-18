//
//  AppDelegate.swift
//  cora
//
//  Created by Lucas Silveira on 16/04/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    private var coordinator: Coordinator!

    lazy var window: UIWindow? = {
        let wind = UIWindow(frame: UIScreen.main.bounds)
        wind.backgroundColor = UIColor.white

        return wind
    }()

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let navigationController = UINavigationController()
        navigationController.viewControllers = []

        window?.rootViewController = navigationController
        window?.backgroundColor = #colorLiteral(red: 0.09803921569, green: 0.1725490196, blue: 0.2274509804, alpha: 1)

        coordinator = LoginCoordinator(withNavigation: navigationController)
        window?.makeKeyAndVisible()
        coordinator.start()

        return true
    }
}
