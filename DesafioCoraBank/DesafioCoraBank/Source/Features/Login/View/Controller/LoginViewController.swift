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
    
    var loginView: LoginView? {
        get { return view as? LoginView }
        set { view = newValue }
    }
    
    override func loadView() {
        self.loginView = LoginView()
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
        
        loginView?.actionButton.onTouch = { [weak self] in
            self?.loginView?.dismissKeyboard()
            
            guard
                let userName = self?.loginView?.authView.loginTextField.text,
                let password = self?.loginView?.authView.passwordTextField.text,
                !userName.isEmpty,
                !password.isEmpty
            else { return }
            
            self?.showLoading(true)
            self?.async {
                self?.interactor?.loginUser(userName: userName, password: password)
            }
        }
    }
    
    func showLoading(_ visible: Bool) {
        loginView?.loading.isHidden = !visible
    }
}

extension LoginViewController: LoginViewControllerProtocol {
    func completeLogin(_ user: UserEntity) {
        showLoading(false)
        print("voltow")
    }
    
    func loginFailed() {
        loginView?.authView.errorText = "login_error_invalid".localized
        showLoading(false)
        loginView?.shake()
    }
}
