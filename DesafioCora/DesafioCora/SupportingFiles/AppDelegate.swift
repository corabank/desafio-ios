//
//  AppDelegate.swift
//  DesafioCora
//
//  Created by user205543 on 2/26/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = LoginFactory.make()
        window?.makeKeyAndVisible()
        return true
    }
}

