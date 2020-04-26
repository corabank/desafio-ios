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
    fileprivate var router: LoginRouter? { return self.getAbstractRouter() as? LoginRouter }
    
    var codeView: LoginView?
    
    override func loadView() {
        super.loadView()
        codeView = LoginView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .cbDarkBlue
        setupCodeView()
        setupAuthAction()
    }
    
    private func setupCodeView() {
        guard let codeView = self.codeView else { return }
        
        view.addSubview(codeView)
        codeView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        codeView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        codeView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        codeView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
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
        codeView?.animateViews()
    }
    
    private func setupAuthAction() {
        
        codeView?.actionButton.onTouch = { [weak self] in
            self?.codeView?.dismissKeyboard()
            
            guard
                let userName = self?.codeView?.authView.loginTextField.text,
                let password = self?.codeView?.authView.passwordTextField.text,
                !userName.isEmpty,
                !password.isEmpty
            else { return }
            
            self?.showLoading(true)
            self?.async {
                self?.interactor?.loginUser(userName: userName, password: password)
            }
        }
    }
}

extension LoginViewController: LoginViewControllerProtocol {
    func completeLogin(_ user: UserEntity) {
        guard let logoImage = codeView?.logoView.logoImage else { return }
        router?.logIn(user: user, logoImage: logoImage)
    }
    
    func loginFailed() {
        codeView?.authView.errorText = "login_error_invalid".localized
        codeView?.shake()
    }
    
    func showLoading(_ visible: Bool) {
        codeView?.loading.isHidden = !visible
    }
}
