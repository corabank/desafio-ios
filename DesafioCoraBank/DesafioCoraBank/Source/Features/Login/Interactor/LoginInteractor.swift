//
//  LoginInteractor.swift
//  DesafioCoraBank
//
//  Created by Roger Sanoli on 21/04/20.
//  Copyright © 2020 RogerSanoli. All rights reserved.
//

import Foundation
import DungeonKit
import RogueKit

class LoginInteractor: DKInteractor {
    fileprivate var presenter: LoginPresenterProtocol? { return self.getAbstractPresenter() as? LoginPresenterProtocol }
}

extension LoginInteractor: LoginInteractorProtocol {
    
    func loginUser(userName: String, password: String) {
        let requestUser = UserEntity(userName: userName, password: password, accessToken: nil)
        RogueKit.request(AuthRepository.loginUser(user: requestUser), enableMocks: self.enableMocks) { [weak self] (result: Result<UserEntity, Error>) in
            switch result {
            case let .success(user):
                self?.presenter?.processLogin(user)
            case .failure(_):
                self?.presenter?.processLoginError()
            }
        }
    }
}
