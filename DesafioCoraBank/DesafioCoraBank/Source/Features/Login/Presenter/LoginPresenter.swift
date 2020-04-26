//
//  LoginPresenter.swift
//  DesafioCoraBank
//
//  Created by Roger Sanoli on 21/04/20.
//  Copyright © 2020 RogerSanoli. All rights reserved.
//

import Foundation
import DungeonKit
import RogueKit

class LoginPresenter: DKPresenter {
    fileprivate var view: LoginViewControllerProtocol? { return self.getAbstractView() as? LoginViewControllerProtocol }
}

extension LoginPresenter: LoginPresenterProtocol {
    func processLogin(_ user: UserEntity) {
        sync { self.view?.completeLogin(user) }
        sync { self.view?.showLoading(false) }
    }
    
    func processLoginError() {
        sync { self.view?.loginFailed() }
        sync { self.view?.showLoading(false) }
    }
}
