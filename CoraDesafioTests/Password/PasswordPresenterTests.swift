//
//  PasswordPresenterTests.swift
//  CoraDesafioTests
//
//  Created by Erik Santos on 24/03/24.
//

import XCTest
@testable import CoraDesafio
final class PasswordPresenterTests: XCTestCase {
    
    private var presenter: PasswordPresenting!
    
    private var coordinatorSpy: OnboardingCoordinatorSpy!
    private var viewSpy: PasswordViewControllerSpy!
    private var serviceSpy: CoraServiceSpy!

    override func setUpWithError() throws {
        self.coordinatorSpy = OnboardingCoordinatorSpy()
        self.viewSpy = PasswordViewControllerSpy()
        self.serviceSpy = CoraServiceSpy()
        self.presenter = PasswordPresenter(coordinator: coordinatorSpy)
        presenter.viewController = viewSpy
    }
    
    func test_Did_Pop() {
        presenter.didPop()
        XCTAssertEqual(1, coordinatorSpy.popCalled)
    }
    
    func test_Start_Loading() {
        presenter.startLoadingButton()
        XCTAssertEqual(1, viewSpy.startLoadingButtonCalled)
    }
    
    func test_Stop_Loading() {
        presenter.stopLoadingButton()
        XCTAssertEqual(1, viewSpy.stopLoadingButtonCalled)
    }
    
    func test_Show_Extract_View() {
        presenter.showExtractView(service: serviceSpy)
        XCTAssertEqual(1, coordinatorSpy.performCalled)
        XCTAssertEqual(OnboardingCoordinatorFlow.extract(serviceSpy), coordinatorSpy.performCalledValue)
    }
    
    func test_Set_Enable_Button_True() {
        presenter.setEnableButton(true)
        XCTAssertEqual(1, viewSpy.setEnableButtonCalled)
        XCTAssert(viewSpy.setEnableButtonValue)
    }
    
    func test_Set_Enable_Button_False() {
        presenter.setEnableButton(false)
        XCTAssertEqual(1, viewSpy.setEnableButtonCalled)
        XCTAssertFalse(viewSpy.setEnableButtonValue)
    }
}
