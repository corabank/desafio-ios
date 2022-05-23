//
//  IntroCoordinatorTests.swift
//  Desafio CoraTests
//
//  Created by João Pedro DTI on 20/05/22.
//

@testable import Desafio_Cora
import XCTest

class IntroCoordinatorTests: BaseCoordinatorTests {

    override func setUp() {
        super.setUp()
    }

    func test_introCoordinatorPresentsSignUpScreen() {
        let introCoordinator = IntroCoordinator(navigationController: navigationController, networkServices: networkServices)
        introCoordinator.goToLogin()
        let presentedController: LoginViewController? = navigationController.viewControllers.first as? LoginViewController
        XCTAssertNotNil(presentedController)
    }
}
