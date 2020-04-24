//
//  LoginView.swift
//  DesafioCoraBank
//
//  Created by Roger Sanoli on 20/04/20.
//  Copyright © 2020 RogerSanoli. All rights reserved.
//

import Foundation
import UIKit
import PaladinKit

final class LoginView: UIView {
    
    private var logoView = LoginLogoView()
    private var logoCenterConstraint: NSLayoutConstraint?
    
    public var authView = LoginAuthView()
    private var authCenterConstraint: NSLayoutConstraint?
    private var authLeadingConstraint: NSLayoutConstraint?
    private var authTrailingConstraint: NSLayoutConstraint?
    
    public var actionButton = CBActionButton()
    public var actionButtonBottomConstraint: NSLayoutConstraint?
    
    public var loading = CBLoading()
    
    private lazy var forgotButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        button.titleLabel?.font = .cbLight(14)
        button.setTitleColor(.cbWhite, for: .normal)
        return button
    }()
    private var forgotButtonBottomConstraint: NSLayoutConstraint?
    
    public var actionButtonBottomConstant: CGFloat = -70
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    public func animateViews(_ forUITests: Bool = false) {
        animateLogo(forUITests)
        animateAuth(forUITests)
        animateActionButton(forUITests)
        animateForgotButton(forUITests)
    }
    
    private func animateLogo(_ forUITests: Bool) {
        guard let constraint = logoCenterConstraint else { return }
        animateView(logoView, constraint: constraint, constant: -230, delay: 0.3, forUITests: forUITests)
    }
    
    private func animateAuth(_ forUITests: Bool) {
        guard let constraint = authCenterConstraint else { return }
        animateView(authView, constraint: constraint, constant: -70, delay: 0.35, forUITests: forUITests)
    }
    
    private func animateActionButton(_ forUITests: Bool) {
        guard let constraint = actionButtonBottomConstraint else { return }
        animateView(actionButton, constraint: constraint, constant: actionButtonBottomConstant, delay: 0.4, forUITests: forUITests)
    }
    
    private func animateForgotButton(_ forUITests: Bool) {
        guard let constraint = forgotButtonBottomConstraint else { return }
        animateView(forgotButton, constraint: constraint, constant: -30, delay: 0.45, forUITests: forUITests)
    }
    
    private func animateView(_ view: UIView, constraint: NSLayoutConstraint, constant: CGFloat, delay: Double, forUITests: Bool) {
        guard forUITests == false else {
            view.alpha = 1
            constraint.constant = constant
            return
        }
        
        constraint.constant = constant
        UIView.animate(withDuration: 0.3, delay: delay, options: .curveEaseIn, animations: {
            self.layoutIfNeeded()
        }, completion: nil)
        
        UIView.animate(withDuration: 0.4, delay: delay+0.1, options: .curveEaseInOut, animations: {
            view.alpha = 1
        }, completion: nil)
    }
    
    override func keyboardWillShow(frame: CGRect) {
        self.actionButtonBottomConstraint?.constant = (frame.size.height * -1) + .cbBottomMargin
        UIView.animate(withDuration: 0.4, delay: 0, options: [.curveEaseIn, .allowUserInteraction, .beginFromCurrentState], animations: {
            self.layoutIfNeeded()
        }, completion: nil)
    }
    
    override func keyboardWillHide() {
        self.actionButtonBottomConstraint?.constant = actionButtonBottomConstant
        UIView.animate(withDuration: 0.4, delay: 0, options: [.curveEaseIn, .allowUserInteraction, .beginFromCurrentState], animations: {
            self.layoutIfNeeded()
        }, completion: nil)
    }
    
    public func shake() {
        authLeadingConstraint?.constant = .cbLeftMargin - 15
        authTrailingConstraint?.constant = .cbRightMargin - 15
        
        UIView.animate(withDuration: 0.05, delay: 0.2, options: .curveLinear, animations: {
            self.layoutIfNeeded()
        }) { (_) in
            self.authLeadingConstraint?.constant = .cbLeftMargin
            self.authTrailingConstraint?.constant = .cbRightMargin
            UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.1, initialSpringVelocity: 0.15, options: .curveEaseInOut, animations: {
                self.layoutIfNeeded()
            }, completion: nil)
        }
    }
}

extension LoginView: CodeView {
    func buildViewHierarchy() {
        addSubview(logoView)
        addSubview(authView)
        addSubview(actionButton)
        addSubview(forgotButton)
        addSubview(loading)
    }
    
    func setupConstraints() {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        logoView.widthAnchor.constraint(equalToConstant: 160).isActive = true
        logoView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        logoCenterConstraint = logoView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0)
        logoCenterConstraint?.isActive = true
        logoView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        
        authLeadingConstraint = authView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: .cbLeftMargin)
        authLeadingConstraint?.isActive = true
        authTrailingConstraint = authView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: .cbRightMargin)
        authTrailingConstraint?.isActive = true
        authView.heightAnchor.constraint(equalToConstant: 140).isActive = true
        authCenterConstraint = authView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 70)
        authCenterConstraint?.isActive = true
        
        actionButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: .cbLeftMargin).isActive = true
        actionButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: .cbRightMargin).isActive = true
        actionButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        actionButtonBottomConstraint = actionButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 50)
        actionButtonBottomConstraint?.isActive = true
        
        forgotButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: .cbLeftMargin).isActive = true
        forgotButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: .cbRightMargin).isActive = true
        forgotButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        forgotButtonBottomConstraint = forgotButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 20)
        forgotButtonBottomConstraint?.isActive = true
        
        loading.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        loading.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        loading.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        loading.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = .cbDarkBlue
        authView.alpha = 0
        actionButton.alpha = 0
        actionButton.title = "login_button_access".localized
        forgotButton.alpha = 0
        forgotButton.setTitle("login_button_forgot_password".localized, for: .normal)
        loading.isHidden = true
    }
}
