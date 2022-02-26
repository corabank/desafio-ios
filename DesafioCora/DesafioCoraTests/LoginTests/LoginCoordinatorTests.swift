//
//  LoginCoordinatorTests.swift
//  DesafioCoraTests
//
//  Created by user205543 on 2/26/22.
//

import Foundation
@testable import DesafioCora
import XCTest

class LoginCoordinatorTests: XCTestCase {
    let mockedViewController = ViewControllerMock()
    
    lazy var sut: LoginCoordinator = {
        let coordinator = LoginCoordinator()
        coordinator.viewController = mockedViewController
        return coordinator
    }()
    
    func testPerform_WhenActionIsLogin_ShouldPresentTransactionsListViewController() {
        sut.perform(action: .login)
        
        XCTAssert(mockedViewController.presentedVC is TransactionsListViewController)
    }
    
}
