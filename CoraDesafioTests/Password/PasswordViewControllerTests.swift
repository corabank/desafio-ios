//
//  PasswordViewControllerTests.swift
//  CoraDesafioTests
//
//  Created by Erik Santos on 24/03/24.
//

import XCTest
import DesignKit
import SnapshotTesting
@testable import CoraDesafio

final class PasswordViewControllerTests: XCTestCase {
    private var passwordInteractorSpy: PasswordInterectorSpy!
    
    override func setUpWithError() throws {
        self.passwordInteractorSpy = PasswordInterectorSpy()
    }
    
    func test_Password_View_Button_Disable() {
        let controller = PasswordViewController(interactor: passwordInteractorSpy)
        assertSnapshot(of: controller, as: .image)
    }
    
    func test_Password_View_Button_Enable() {
        let controller = PasswordViewController(interactor: passwordInteractorSpy)
        controller.setEnableButton(true)
        assertSnapshot(of: controller, as: .image)
    }
    
    func test_Password_View_Did_Pop() {
        let controller = PasswordViewController(interactor: passwordInteractorSpy)
        controller.didTapLeftButton()
        
        XCTAssertEqual(1, passwordInteractorSpy.didPopCalled)
    }
    
    func test_Validate_Password() {
        let controller = PasswordViewController(interactor: passwordInteractorSpy)
        controller.didUpdatePasswordText("123")
        XCTAssertEqual(1, passwordInteractorSpy.validatePasswordCalled)
        XCTAssertEqual("123", passwordInteractorSpy.validatePasswordValue)
    }
    
    func test_Save_Validate_Password() {
        let controller = PasswordViewController(interactor: passwordInteractorSpy)
        controller.didTapLogginButton(CoraButtonView.instantiate(viewModel: Mock.coraButton, action: {_ in}), correctValue: "123")
        
        XCTAssertEqual(1, passwordInteractorSpy.savePasswordOnMemoryCalled)
        XCTAssertEqual("123", passwordInteractorSpy.savePasswordOnMemoryValue)
    }
}

extension PasswordViewControllerTests {
    enum Mock {
        static let coraButton = CoraButtonViewModel(title: CoraAccessibleText(text: "", textColor: .white, backgroundColor: .white), icon: nil, font: nil, size: .small)
    }
}
