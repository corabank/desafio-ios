//
//  LoginViewControllerTests.swift
//  CoraDesafioTests
//
//  Created by Erik Santos on 24/03/24.
//

import XCTest
import SnapshotTesting
import DesignKit
@testable import CoraDesafio

final class LoginViewControllerTests: XCTestCase {

    private var loginInteractorSpy: LoginInteractorSpy!
    
    override func setUpWithError() throws {
        self.loginInteractorSpy = LoginInteractorSpy()
    }
    
    func test_Login_View_Button_Disable() {
        let controller = LoginViewController(interactor: loginInteractorSpy)
        assertSnapshot(of: controller, as: .image)
    }
    
    func test_Login_View_Button_Enable() {
        let controller = LoginViewController(interactor: loginInteractorSpy)
        controller.setEnableButton(true)
        assertSnapshot(of: controller, as: .image)
    }
    
    func test_SLogin_View_Save_Memory_Called() {
        let controller = LoginViewController(interactor: loginInteractorSpy)
        controller.didTapConfirmButton(CoraButtonView.instantiate(viewModel: Mock.coraButton, action: {_ in}), correctValue: "440.437.628.60")
        XCTAssertEqual(1, loginInteractorSpy.saveCpfOnMemoryCalled)
        XCTAssertEqual("440.437.628.60", loginInteractorSpy.cpfValue)
    }
    
    func test_Login_View_Did_Pop_Called() {
        let controller = LoginViewController(interactor: loginInteractorSpy)
        controller.didTapLeftButton()
        XCTAssertEqual(1, loginInteractorSpy.didPopCalled)
    }
    
    func test_Login_View_Did_Pop_Called1() {
        let controller = LoginViewController(interactor: loginInteractorSpy)
        controller.didUpdateCpfText("440")
        XCTAssertEqual(1, loginInteractorSpy.validateCpfInputCalled)
        XCTAssertEqual("440", loginInteractorSpy.validateCpfInputValue)
    }
}

extension LoginViewControllerTests {
    enum Mock {
        static let coraButton = CoraButtonViewModel(title: CoraAccessibleText(text: "", textColor: .white, backgroundColor: .white), icon: nil, font: nil, size: .small)
    }
}
