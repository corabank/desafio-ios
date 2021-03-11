//
//  SignUpViewController.swift
//  DesafioCora
//
//  Created by Euclides Medeiros on 10/03/21.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {
    
    var signUpView: SignUpView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "teste"
        setupViews()
    }
    
    func setupViews() {
        let signUpView = SignUpView(frame: self.view.frame)
        self.signUpView = signUpView
        self.signUpView.signUpAction = submmitPressed
        view.addSubview(signUpView)
    }
    
    func submmitPressed() {
        guard let email = signUpView.emailSignUpTextField.text,
              let password = signUpView.passwordSignUpTextFied.text else { return }
        
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if let err = error {
                print(error?.localizedDescription)
            } else {
                guard let uid = result?.user.uid else { return }
                print("Isso mesmo, usuário criado!!!", uid)
            }
        }
    }
    
}
