//
//  PasswordViewController.swift
//  Desafio Cora
//
//  Created by João Pedro DTI on 13/05/22.
//

import Foundation
import UIKit

class PasswordViewController: UIViewController {
    weak var coordinator: PasswordCoordinator?
    var screen: PasswordScreen?

    override func loadView() {
        screen = PasswordScreen()
        screen?.delegate = self
        self.view = screen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = Strings.coraLogin
    }
}

extension PasswordViewController: PasswordScreenDelegate {
    func lostPasswordButtonTapped() {
        coordinator?.showAlert(title: "Email Enviado!", message: "Confira sua caixa de entrada!")
    }

    func nextButtonPressed() {
        coordinator?.goToInvoice()
    }
}
