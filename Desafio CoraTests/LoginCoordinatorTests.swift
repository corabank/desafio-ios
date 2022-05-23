//
//  LoginCoordinatorTests.swift
//  Desafio CoraTests
//
//  Created by João Pedro DTI on 23/05/22.
//

@testable import Desafio_Cora
import XCTest

class LoginCoordinatorTests: BaseCoordinatorTests {

    override func setUp() {
        super.setUp()
    }

    func test_cnppjCoordinatorPresentsPasswordScreen() {
        let loginCoordinator = LoginCoordinator(navigationController: navigationController, networkServices: networkServices)
        loginCoordinator.goToPassword()
        let presentedController: PasswordViewController? = navigationController.viewControllers.first as? PasswordViewController
        XCTAssertNotNil(presentedController)
    }

    func test_passwordCoordinatorPresentsInvoiceScreen() {
        let loginCoordinator = PasswordCoordinator(navigationController: navigationController, networkService: networkServices)
        loginCoordinator.goToInvoice()
        let presentedController: InvoiceViewController? = navigationController.viewControllers.first as? InvoiceViewController
        XCTAssertNotNil(presentedController)
    }
}
