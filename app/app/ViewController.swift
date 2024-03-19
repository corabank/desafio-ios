//
//  ViewController.swift
//  app
//
//  Created by João Gabriel Dourado Cervo on 13/03/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async { [weak self] in
            if let sceneDelegate = self?.view.window?.windowScene?.delegate as? SceneDelegate {
                sceneDelegate.appNavigationService?.openLoginViewController()
            }
        }
    }


}

