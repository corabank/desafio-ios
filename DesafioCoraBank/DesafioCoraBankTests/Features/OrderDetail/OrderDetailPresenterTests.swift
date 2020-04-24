//
//  OrderDetailPresenterTests.swift
//  DesafioCoraBankTests
//
//  Created by Roger Sanoli on 23/04/20.
//  Copyright © 2020 RogerSanoli. All rights reserved.
//

import XCTest
@testable import DungeonKit
@testable import DesafioCoraBank

class OrderDetailPresenterTests: XCTestCase {
    
    private var presenter: OrderDetailPresenter!
    
    private let timeout = 10.0
    private var valueCellPromise: XCTestExpectation?
    private var iconInfoCellPromise: XCTestExpectation?
    private var sectionHeaderCellPromise: XCTestExpectation?
    private var textInfoCellPromise: XCTestExpectation?
    private var sandboxCellPromise: XCTestExpectation?
    private var errorPromise: XCTestExpectation?
    
    override func setUp() {
        presenter = OrderDetailPresenter()
        presenter.setView(self)
    }
    
    override func tearDown() {
        presenter = nil
    }
    
    func testViewModels() {
        valueCellPromise = expectation(description: "Should create a consistent value view model.")
        iconInfoCellPromise = expectation(description: "Should create a consistent icon info view model.")
        sectionHeaderCellPromise = expectation(description: "Should create a consistent section header view model.")
        textInfoCellPromise = expectation(description: "Should create a consistent text info view model.")
        sandboxCellPromise = expectation(description: "Should create a consistent sandbox view model.")
        self.presenter.processOrder(entity: self.generateMockedOrder())
        self.wait(for: [self.valueCellPromise!, self.iconInfoCellPromise!, self.sectionHeaderCellPromise!, self.textInfoCellPromise!, self.sandboxCellPromise!], timeout: timeout)
    }
    
    func testError() {
        errorPromise = expectation(description: "Should alert view when not able to create a view model.")
        self.presenter.processOrder(entity: nil)
        self.wait(for: [self.errorPromise!], timeout: timeout)
    }
    
    private func generateMockedOrder() -> OrderEntity {
        
        var mock = OrderEntity()
        mock.id = "1"
        mock.value = 100.10
        mock.email = "email1@email.com"
        mock.date = generateMockedDate()
        mock.status = .paid
        mock.paymentMethod = .credit
        mock.buyerName = "Caju Cacau"
        mock.taxes = 4.99
        mock.sandbox = "1"
        
        return mock
    }
    
    private func generateMockedDate() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        return dateFormatter.date(from: "20-02-2020") ?? Date()
    }
}

/*
    QUICK NOTE - The 'guards' in the beginning of the following tests have the purpose of not allowing a promise to be called twice, as well as to guarantee a test on the correct view model.
 */

extension OrderDetailPresenterTests: OrderDetailViewControllerProtocol {
    func addValueCell(viewModel: OrderCellViewModel) {
        guard viewModel.value == "R$100.10" else { return }
        
        XCTAssertNotNil(viewModel, "Should have a View Model.")
        XCTAssertNotNil(viewModel.iconImageName, "Should have an icon.")
        XCTAssertEqual(viewModel.value, "R$100.10", "Should format the value.")
        XCTAssertEqual(viewModel.subtitle, "Credit card", "Should present the payment method on subtitle.")
        valueCellPromise?.fulfill()
    }
    
    func addIconInfoCell(viewModel: OrderDetailIconInfoViewModel) {
        guard viewModel.fieldText == "Buyer" else { return }
        
        XCTAssertNotNil(viewModel, "Should have a View Model.")
        XCTAssertNotNil(viewModel.iconImageName, "Should have an icon.")
        XCTAssertEqual(viewModel.fieldText, "Buyer", "Should have a valid field.")
        XCTAssertEqual(viewModel.valueText, "Caju Cacau", "Should have a valid value.")
        XCTAssertEqual(viewModel.valueColor, .cbBlack, "Should have the correct color.")
        iconInfoCellPromise?.fulfill()
    }
    
    func addSectionHeaderCell(viewModel: OrderDetailSectionHeaderViewModel) {
        guard viewModel.sectionTitle == "Financial summary" else { return }
        
        XCTAssertNotNil(viewModel, "Should have a View Model.")
        XCTAssertEqual(viewModel.sectionTitle, "Financial summary", "Should have the correct title.")
        sectionHeaderCellPromise?.fulfill()
    }
    
    func addTextInfoCell(viewModel: OrderDetailTextInfoViewModel) {
        guard viewModel.fieldText == "Total value" else { return }
        
        XCTAssertNotNil(viewModel, "Should have a View Model.")
        XCTAssertEqual(viewModel.fieldText, "Total value", "Should have a valid field.")
        XCTAssertEqual(viewModel.currency, "R$", "Should have a valid currency.")
        XCTAssertEqual(viewModel.valueText, "100.10", "Should have a valid value.")
        XCTAssertEqual(viewModel.fontSize, 14 , "Should have the correct font size.")
        XCTAssertEqual(viewModel.fontColor, .cbBlack, "Should have the correct color.")
        
        textInfoCellPromise?.fulfill()
    }
    
    func addSandboxCell(viewModel: OrderDetailSandboxViewModel) {
        guard viewModel.sandbox == "sandbox: 1" else { return }
        
        XCTAssertNotNil(viewModel, "Should have a View Model.")
        XCTAssertEqual(viewModel.sandbox, "sandbox: 1", "Should have a sandbox.")
        sandboxCellPromise?.fulfill()
    }
    
    func alertErrorLoadingData() {
        errorPromise?.fulfill()
    }
    
    func setInteractor(_ abstractInteractor: DKAbstractInteractor) {}
}
