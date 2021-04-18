//
//  LoginRepositoryTests.swift
//  coraTests
//
//  Created by Lucas Silveira on 16/04/21.
//

import XCTest
import SwiftyMocky
@testable import cora

class LoginRepositoryTests: XCTestCase {
    var userDTO: UserDTO!

    let email = "john.due@mail.com"
    let password = "lorem"

    var loginDataSource: LoginDataSourceProtocolMock!
    var loginRepository: LoginRepository!
    
    override func setUp() {
        super.setUp()
        
        userDTO = UserDTO(
            id: UUID().uuidString,
            name: "John Due",
            email: "john.due@mail.com"
        )

        loginDataSource = LoginDataSourceProtocolMock()
        loginRepository = LoginRepository(loginDataSource: loginDataSource)
    }
    
    func login() throws -> User? {
        var result: Result<User, Error>?
        loginRepository.login(email: email, password: password) { result = $0 }
        return try result?.get()
    }
    
    func test_login_repository_with_dto_should_return_user() throws {
        loginDataSource.perform(
            .login(
                email: .any,
                password: .any,
                completionHandler: .any,
                perform: { (email, password, completionHandler) in
                    completionHandler(.success(self.userDTO))
        }))
        
        let user = try login()
        
        XCTAssertEqual(user?.email, "john.due@mail.com")

        loginDataSource.verify(.login(email: .any, password: .any, completionHandler: .any))
    }
    
    func test_login_repository_should_return_error() throws {
        loginDataSource.perform(
            .login(
                email: .any,
                password: .any,
                completionHandler: .any,
                perform: { (email, password, completionHandler) in
                    completionHandler(.failure(URLError(.unknown)))
        }))
        
        XCTAssertThrowsError(try login())
        loginDataSource.verify(.login(email: .any, password: .any, completionHandler: .any))
    }
}
