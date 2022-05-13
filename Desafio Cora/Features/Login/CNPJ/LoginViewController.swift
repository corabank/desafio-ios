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
    var screen: LoginScreen?

    override func loadView() {
        screen = LoginScreen()
        self.view = screen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Login Cora"
    }
}
