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
        initializeHideKeyboard()
    }

    func setupView() {
        let mainView = LoginView(frame: self.view.frame)
        self.loginView = mainView
        self.view.addSubview(loginView)
        self.loginView.loginAction = loginPressed
        self.loginView.signUpAction = signUpPressed
    }
    
    func loginPressed() {
        print("Banana")
    }
    
    func signUpPressed() {
        let goToSignUpScreen = SignUpViewController()
        goToSignUpScreen.modalPresentationStyle = .fullScreen
        present(goToSignUpScreen, animated: true, completion: nil)
        
    }
}

extension LoginViewController {
    
    func initializeHideKeyboard(){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissMyKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissMyKeyboard(){
        view.endEditing(true)
    }
    
}
