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
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        setupNavigation()
        setupViews()
    }
    
    func setupViews() {
        view.backgroundColor = .white
        self.title = "signup"
        let signUpView = SignUpView(frame: self.view.frame)
        self.signUpView = signUpView
        self.signUpView.signUpAction = submmitPressed
        view.addSubview(signUpView)
    }
    
    private func setupNavigation() {
        let backbutton = UIButton(type: .custom)
        backbutton.setTitle("voltar", for: .normal)
        backbutton.setTitleColor(backbutton.tintColor, for: .normal)
        backbutton.addTarget(self, action: #selector(self.backAction), for: .touchUpInside)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backbutton)
        }
    
    @objc func backAction() -> Void {
        dismiss(animated: true, completion: nil)
    }
    
    func submmitPressed() {
        guard let email = signUpView.emailSignUpTextField.text,
              let password = signUpView.passwordSignUpTextFied.text,
              let userName = signUpView.nameSignUpTextField.text else { return }
        
        let userData: [String: Any] = [
            "name": userName
        ]
        
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if let err = error {
                print(err.localizedDescription)
            } else {
                guard let uid = result?.user.uid else { return }
                self.ref.child("users/\(uid)").setValue(userData)
                print("Isso mesmo, usuário criado!!!", uid)
            }
        }
    }
}
