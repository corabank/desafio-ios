//
//  IntroViewController.swift
//  Desafio Cora
//
//  Created by João Pedro DTI on 11/05/22.
//

import UIKit

class IntroViewController: UIViewController {
    weak var coordinator: IntroCoordinator?
    let screen = IntroScreen()

    override func loadView() {
        screen.delegate = self
        self.view = screen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - Extensions
extension IntroViewController: IntroScreenDelegate {
    func buttonSignupPressed() {
        coordinator?.showAlert(title: "Criar Conta", message: "Crie Sua Conta!!")
    }

    func buttonLoginPressed() {
        coordinator?.goToLogin()
    }
}
