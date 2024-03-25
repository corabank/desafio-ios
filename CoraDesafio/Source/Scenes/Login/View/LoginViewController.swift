//
//  LoginViewController.swift
//  CoraDesafio
//
//  Created by Erik Santos on 14/03/24.
//

import UIKit
import DesignKit

protocol LoginDisplaying: AnyObject {
    func setEnableButton(_ isEnable: Bool)
}

class LoginViewController: BaseViewController<LoginInteracting, LoginView> {
    
    // MARK: - Life Cycles

    override func viewDidLoad() {
        super.viewDidLoad()
        prepareView()
        setupDelegates()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        rootView.setCpfFieldActive()
    }
    
    // MARK: - Private Methods
    
    private func setupDelegates() {
        navigationCora.delegate = self
        rootView.delegate = self
    }
    
    private func prepareView() {
        rootView.backgroundColor = .white
        navigationCora.setViewModel(setDefaultNavigation(title: CoraStrings.Commons.Navigation.loginCora))
        rootView.setCpfFieldActive()
        rootView.setEnableButton(false)
    }
}

// MARK: - LoginDisplaying + Delegates

extension LoginViewController: LoginDisplaying, LoginViewDelegate {
    func setEnableButton(_ isEnable: Bool) {
        rootView.setEnableButton(isEnable)
    }
    
    func didUpdateCpfText(_ value: String) {
        interactor.validateCpfInput(value)
    }
    
    func didTapConfirmButton(_ button: CoraButtonView, correctValue: String) {
        interactor.saveCpfOnMemory(correctValue)
    }
}

extension LoginViewController: StickNavigationViewDelegate {
    func didTapLeftButton() {
        interactor.didPop()
    }
}
