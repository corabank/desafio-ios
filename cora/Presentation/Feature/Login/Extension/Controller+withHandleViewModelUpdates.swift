//
//  Controller+withHandleViewModelUpdates.swift
//  cora
//
//  Created by Lucas Silveira on 28/04/21.
//

import UIKit

extension LoginViewController {
    
    /// handleFailures
    /// - Parameter state: LoginViewModelState failures handled from LoginViewModel
    func handleFailures(state: LoginViewModelState) {
        switch state {
        case .invalidEmail:
            invalidEmail()
        case .wrongEmailAndPassword:
            wrongEmailAndPassword()
        case .emailEmpty:
            emailEmpty()
        case .passwordEmpty:
            passwordEmpty()
        case .emailAndPasswordEmpty:
            emailAndPasswordEmpty()
        default: break
        }
    }
    
    func handleLogin(state: LoginViewModelState) {
        disableLoading()
        switch state {
        case .authenticating: authenticating()
        case .authenticated: authenticated()
        default: break
        }
    }
    
    func handleState(state: LoginViewModelState) {
        handleLogin(state: state)
        handleFailures(state: state)
    }
    
    private func authenticating() {
        loading.startAnimating()
    }
    
    private func authenticated() {
        disableLoading()
        endAnimation()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.delegate?.authenticated()
        }
    }
    
    private func invalidEmail() {
        self.errorLabel.text = "Invalid email or password".localized
        shakeElements()
    }
    
    private func wrongEmailAndPassword() {
        self.errorLabel.text = "Invalid email or password".localized
        self.passwordTextInput.text = ""
        self.passwordTextInput.becomeFirstResponder()
        shakeElements()
    }
    
    private func emailEmpty() {
        errorLabel.text = "Email is required".localized
        shakeElements()
    }
    
    private func passwordEmpty() {
        errorLabel.text = "Password is required".localized
        shakeElements()
    }
    
    private func emailAndPasswordEmpty() {
        errorLabel.text = "Email and password are required".localized
        shakeElements()
    }
    
    private func disableLoading() {
        loading.stopAnimating()
    }
    
    private func shakeElements() {
        emailTextInput.shake()
        passwordTextInput.shake()
        errorLabel.shake()
    }
    
    /// endAnimation() is fired when transition to show orders begins
    private func endAnimation() {
        self.mainStack.isHidden = true
        self.logoView.moveLogo()
        self.makeHeaderView()
    }
}
