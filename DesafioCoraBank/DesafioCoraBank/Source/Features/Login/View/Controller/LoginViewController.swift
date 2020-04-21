//
//  LoginViewController.swift
//  DesafioCoraBank
//
//  Created by Roger Sanoli on 21/04/20.
//  Copyright © 2020 RogerSanoli. All rights reserved.
//

import Foundation
import DungeonKit

class LoginViewController: DKViewController<LoginRouter> {
    
    fileprivate var interactor: LoginInteractorProtocol? { return self.getAbstractInteractor() as? LoginInteractorProtocol }
    
    override func loadView() {
        self.view = LoginView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAuthAction()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.registerForKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        view.deregisterFromKeyboardNotifications()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        guard let loginView = self.view as? LoginView else { return }
        loginView.animateViews()
    }
    
    private func setupAuthAction() {
        
        guard let loginView = self.view as? LoginView else { return }
        
        loginView.actionButton.onTouch = { [weak self] in
            guard
                let userName = loginView.authView.loginTextField.text,
                let password = loginView.authView.passwordTextField.text,
                !userName.isEmpty,
                !password.isEmpty
            else { return }
            
            self?.async {
                self?.interactor?.loginUser(userName: userName, password: password)
            }
        }
    }
    
}

extension LoginViewController: LoginViewControllerProtocol {

}
