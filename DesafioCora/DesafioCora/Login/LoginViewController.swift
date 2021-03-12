//
//  ViewController.swift
//  DesafioCora
//
//  Created by Euclides Medeiros on 09/03/21.
//

import UIKit
import Firebase

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
        guard let email = loginView.emailTextField.text,
              let password = loginView.passwordTextFied.text else { return }
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if let err = error {
                self.showAlert(alertText: "Error", alertMessage: "\(err.localizedDescription)")
            } else {
                let goToOrderListVc = UINavigationController(rootViewController: OrderListViewController())
                self.present(goToOrderListVc, animated: true, completion: nil)
            }
        }
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
    
    func showAlert(alertText : String, alertMessage : String) {
        let alert = UIAlertController(title: alertText, message: alertMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Got it", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}
