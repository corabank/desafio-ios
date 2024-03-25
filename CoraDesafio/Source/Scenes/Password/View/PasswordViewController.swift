//
//  PasswordViewController.swift
//  CoraDesafio
//
//  Created by Erik Santos on 14/03/24.
//

import UIKit
import DesignKit


protocol PasswordDisplaying: AnyObject {
    func setEnableButton(_ value: Bool)
    func startLoadingButton()
    func stopLoadingButton()
}

class PasswordViewController: BaseViewController<PasswordInteracting, PasswordView> {
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegate()
        prepareView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        rootView.setPasswordFieldActive()
    }
    
    // MARK: - Private Methods
    
    private func setupDelegate() {
        rootView.delegate = self
        navigationCora.delegate = self
    }
    
    private func prepareView() {
        rootView.backgroundColor = .white
        navigationCora.setViewModel(setDefaultNavigation(title: CoraStrings.Commons.Navigation.loginCora))
        rootView.setEnableButton(false)
    }
}

// MARK: - PasswordDisplaying + Delegates

extension PasswordViewController: PasswordDisplaying, PasswordViewDelegate {
    func startLoadingButton() {
        rootView.setLoadingButton()
    }
    
    func stopLoadingButton() {
        rootView.stopLoadingButton()
    }
    
    func setEnableButton(_ value: Bool) {
        rootView.setEnableButton(value)
    }
    
    func didTapForgotPassword(_ sender: CoraButtonView) {
        /* Intentionaly Implemented */
    }
    
    func didTapLogginButton(_ sender: CoraButtonView, correctValue: String) {
        interactor.savePasswordOnMemory(correctValue)
    }
    
    func didUpdatePasswordText(_ value: String) {
        interactor.validatePassword(value)
    }
}

extension PasswordViewController: StickNavigationViewDelegate {
    func didTapLeftButton() {
        interactor.didPop()
    }
}
