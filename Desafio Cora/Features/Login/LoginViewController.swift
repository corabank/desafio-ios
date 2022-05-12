//
//  LoginViewController.swift
//  Desafio Cora
//
//  Created by João Pedro DTI on 11/05/22.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {
    weak var coordinator: LoginCoordinator?

    override func loadView() {
        let view = UIView(frame: UIScreen.main.bounds)
        view.backgroundColor = .blue
        self.view = view
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
