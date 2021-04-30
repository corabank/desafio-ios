//
//  LoginPresenter.swift
//  cora
//
//  Created by Lucas Silveira on 16/04/21.
//

import Foundation

//sourcery: AutoMockable
protocol LoginPresenter: AnyObject {
    func authenticating()
    func loginSuccess(user: User)
    func loginError(error: LoginUseCaseError)
}
