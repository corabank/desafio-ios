//
//  LoginPresenter.swift
//  DesafioCoraBank
//
//  Created by Roger Sanoli on 21/04/20.
//  Copyright © 2020 RogerSanoli. All rights reserved.
//

import Foundation
import DungeonKit

class LoginPresenter: DKPresenter {
    fileprivate var view: LoginViewControllerProtocol? { return self.getAbstractView() as? LoginViewControllerProtocol }
}

extension LoginPresenter: LoginPresenterProtocol {

}
