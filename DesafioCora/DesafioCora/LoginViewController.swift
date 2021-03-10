//
//  ViewController.swift
//  DesafioCora
//
//  Created by Euclides Medeiros on 09/03/21.
//

import UIKit

class LoginViewController: UIViewController {

    var loginView: LoginView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
    }

    func setupView() {
        let mainView = LoginView(frame: self.view.frame)
        self.loginView = mainView
        self.view.addSubview(loginView)
        self.loginView.loginAction = loginPressed
    }
    
    func loginPressed() {
        print("Banana")
    }
    
}
