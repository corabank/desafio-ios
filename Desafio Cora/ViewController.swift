//
//  ViewController.swift
//  Desafio Cora
//
//  Created by João Pedro DTI on 11/05/22.
//

import UIKit

class ViewController: UIViewController {
    weak var coordinator: ViewControllerCoordinator?
    let screen = LoginScreen()

    override func loadView() {
        self.view = screen
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
