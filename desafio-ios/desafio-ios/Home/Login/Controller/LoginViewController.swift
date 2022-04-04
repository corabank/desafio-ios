//
//  LoginViewController.swift
//  desafio-ios
//
//  Created by Amaryllis Baldrez on 13/03/22.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {
    
    private let loginView: LoginView = {
        let loginView = LoginView()
        return loginView
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        setupButton()
        self.navigationItem.title = "Login Cora"
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                if self.view.frame.origin.y == 0 {
                    self.view.frame.origin.y -= keyboardSize.height
                }
            }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
                self.view.frame.origin.y = 0
            }
    }
    
    override func viewWillLayoutSubviews() {
          
       }
    
    @objc func selectorX() {
        print("aloooo")
    }
    
    override func loadView() {
        self.view = loginView
    }
    
    func setupButton() {
        loginView.continueButton.addTarget(self, action: #selector(pushToPassword), for: .touchUpInside)
    }
    
    @objc func pushToPassword() {
        let passwordViewController = PasswordViewController()
        navigationController?.pushViewController(passwordViewController, animated: true)
    }
    
    func setupStyle() {
        view.backgroundColor = .white
    }
}
