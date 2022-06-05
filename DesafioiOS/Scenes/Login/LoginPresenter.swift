//
//  LoginPresenter.swift
//  DesafioiOS
//
//  Created by Allana Castenharo Santamaria on 28/05/22.
//

import UIKit

protocol LoginPresenting: AnyObject {
    var viewController: LoginDisplaying? { get }
    func presentValidation(isValid: Bool)
    func presentPassordView()
    func presentExtract()
}

final class LoginPresenter: CoraPresenter<LoginCoordinating> {
    weak var viewController: LoginDisplaying?
}

extension LoginPresenter: LoginPresenting {
    func presentValidation(isValid: Bool) {
        viewController?.enableButton(isValid)
    }
    
    func presentPassordView() {
        coordinator.showPassword()
    }
    
    func presentExtract() {
        coordinator.showExtract()
    }
}
