//
//  OrderDetailViewControllerTests.swift
//  DesafioCoraBankTests
//
//  Created by Roger Sanoli on 26/04/20.
//  Copyright © 2020 RogerSanoli. All rights reserved.
//

import XCTest
@testable import DungeonKit
@testable import DesafioCoraBank

class OrderDetailViewControllerTests: XCTestCase {
    
    private var controller: OrderDetailViewController!
    static var presenter: OrderDetailPresenter? = OrderDetailPresenter()
    
    private let timeout = 30.0
    static var fetchingSuccessPromise: XCTestExpectation?
    static var fetchingFailurePromise: XCTestExpectation?
    
    override func setUp() {
        
    }
    override func tearDown() {
        controller = nil
    }
    
    func testSuccessfulFetch() {
        controller = OrderDetailViewControllerMock()
        controller.orderID = "1"
        (controller as? OrderDetailViewControllerMock)?.responseError = false
        OrderDetailViewControllerTests.presenter?.setView(controller)
        OrderDetailViewControllerTests.fetchingSuccessPromise = expectation(description: "Should be able to fetch data.")
        controller.loadView()
        controller.viewDidLoad()
        controller.viewDidAppear(true)
        self.wait(for: [OrderDetailViewControllerTests.fetchingSuccessPromise!], timeout: timeout)
    }
    
    func testErrorHandling() {
        controller = OrderDetailViewControllerMock()
        controller.orderID = "1"
        (controller as? OrderDetailViewControllerMock)?.responseError = true
        OrderDetailViewControllerTests.presenter?.setView(controller)
        OrderDetailViewControllerTests.fetchingFailurePromise = expectation(description: "Should notify when fetch fails.")
        controller.loadView()
        controller.viewDidLoad()
        controller.viewDidAppear(true)
        self.wait(for: [OrderDetailViewControllerTests.fetchingFailurePromise!], timeout: timeout)
    }
    
    func testClearStackView() {
        controller = OrderDetailViewController()
        controller.loadView()
        let view = UIView(frame: .zero)
        controller.codeView?.stackView.addArrangedSubview(view)
        controller.clearStackView()
        XCTAssertEqual(controller.codeView?.stackView.arrangedSubviews.count, 0, "Should remove all arranged subviews.")
    }
}

class OrderDetailViewControllerMock: OrderDetailViewController {
    
    public var responseError: Bool = false
    
    override func getAbstractInteractor() -> DKAbstractInteractor? {
        return self
    }
    
    override func updateLoading(_ visible: Bool) {
        super.updateLoading(visible)
        
        if visible == false {
            OrderDetailViewControllerTests.fetchingSuccessPromise?.fulfill()
        }
    }
    
    override func showError() {
        super.showError()
        OrderDetailViewControllerTests.fetchingFailurePromise?.fulfill()
    }
}

extension OrderDetailViewControllerMock: OrderDetailInteractorProtocol {
    func fetchOrderDetail(orderID: String) {
        if responseError == false {
            OrderDetailViewControllerTests.presenter?.processOrder(entity: generateMock())
        } else {
            OrderDetailViewControllerTests.presenter?.processOrder(entity: nil)
        }
    }
    
    func setPresenter(_ abstractPresenter: DKAbstractPresenter) {}
    
    private func generateMock() -> OrderEntity {
        return OrderEntity(id: "1", value: 100.10, email: "email1@email.com", status: .paid, date: generateMockedDate(), paymentMethod: .credit, buyerName: "Caju Cacau", taxes: 4.99, sandbox: "b463456nsd-3454353 345345 345345-345345 fiogsdgbjk3h45j6343")
    }
    
    private func generateMockedDate() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        return dateFormatter.date(from: "20-02-2020") ?? Date()
    }
}
