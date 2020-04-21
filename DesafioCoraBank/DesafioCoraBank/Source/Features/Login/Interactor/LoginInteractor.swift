//
//  LoginInteractor.swift
//  DesafioCoraBank
//
//  Created by Roger Sanoli on 21/04/20.
//  Copyright © 2020 RogerSanoli. All rights reserved.
//

import Foundation
import DungeonKit

class LoginInteractor: DKInteractor {
    fileprivate var presenter: LoginPresenterProtocol? { return self.getAbstractPresenter() as? LoginPresenterProtocol }
}

extension LoginInteractor: LoginInteractorProtocol {
    func loginUser(userName: String, password: String) {
        print("So far so good!")
    }
    

}
