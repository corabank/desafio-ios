//
//  LoginServiceMock.swift
//  CoraTestTests
//
//  Created by Sandor Ferreira on 28/07/21.
//

import Foundation
@testable import CoraTest

final class LoginServiceMock: LoginServicing {
    func login(with username: String, and pwd: String, completion: (Result<Bool, Error>) -> Void) {
        completion(.success(true))
    }
}
