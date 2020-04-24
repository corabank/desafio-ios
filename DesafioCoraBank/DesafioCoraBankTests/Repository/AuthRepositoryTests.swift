//
//  AuthRepositoryTests.swift
//  DesafioCoraBankTests
//
//  Created by Roger Sanoli on 22/04/20.
//  Copyright © 2020 RogerSanoli. All rights reserved.
//

import XCTest
@testable import RogueKit
@testable import DesafioCoraBank

class AuthRepositoryTests: XCTestCase {
    
    private var requestFailurePromise: XCTestExpectation?

    func testRequestGeneration() {
        requestFailurePromise = expectation(description: "Should fail due to invalid endpoint")
        
        let mockUser = UserEntity(userName: "Roger", password: "cora", accessToken: nil)
        RogueKit.request(AuthRepository.loginUser(user: mockUser)) { (result: Result<UserEntity, Error>) in
            if case .failure = result {
                self.requestFailurePromise?.fulfill()
            }
        }
        
        self.wait(for: [self.requestFailurePromise!], timeout: 60)
    }
    
    func testInvalidEntity() {
        requestFailurePromise = expectation(description: "Should fail due to invalid entity")
        
        let mockUser = UserEntity(userName: "Roger", password: "cora", accessToken: nil)
        RogueKit.request(AuthRepository.loginUser(user: mockUser), enableMocks: true) { (result: Result<OrderEntity, Error>) in
            if case .failure = result {
                self.requestFailurePromise?.fulfill()
            }
        }
        
        self.wait(for: [self.requestFailurePromise!], timeout: 60)
    }
}
