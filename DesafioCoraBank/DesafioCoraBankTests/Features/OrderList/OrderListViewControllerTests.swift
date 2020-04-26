//
//  OrderListViewControllerTests.swift
//  DesafioCoraBankTests
//
//  Created by Roger Sanoli on 26/04/20.
//  Copyright © 2020 RogerSanoli. All rights reserved.
//

import XCTest
@testable import DungeonKit
@testable import DesafioCoraBank

class OrderListViewControllerTests: XCTestCase {
    
    private var controller: OrderListViewController!
    static var presenter: OrderListPresenter? = OrderListPresenter()
    static var router: OrderListRouterMock? = OrderListRouterMock()
    
    private let timeout = 10.0
    static var fetchingSuccessPromise: XCTestExpectation?
    static var selectionPromise: XCTestExpectation?
    static var fetchingFailurePromise: XCTestExpectation?
    
    override func setUp() {
        
    }
    override func tearDown() {
        controller = nil
    }
    
    func testSuccessfulFetch() {
        controller = OrderListViewControllerMock()
        (controller as? OrderListViewControllerMock)?.responseError = false
        OrderListViewControllerTests.presenter?.setView(controller)
        OrderListViewControllerTests.fetchingSuccessPromise = expectation(description: "Should be able to fetch data.")
        controller.loadView()
        controller.viewDidLoad()
        controller.viewDidAppear(true)
        self.wait(for: [OrderListViewControllerTests.fetchingSuccessPromise!], timeout: timeout)
    }
    
    func testSelection() {
        controller = OrderListViewControllerMock()
        controller.router = OrderListViewControllerTests.router
        OrderListViewControllerTests.router?.viewController = controller

        OrderListViewControllerTests.selectionPromise = expectation(description: "Should be able to see the detail.")

        let tableView = UITableView()
        controller.dataSource = OrderListTableViewDataSource(tableView)
        controller.setupSelectionAction()
        let entity = OrderEntity(id: "1", value: 0, email: "", status: .paid, date: Date(), paymentMethod: .credit, buyerName: "", taxes: 0, sandbox: "")
        let viewModel = OrderValueViewModel(entity)
        controller.dataSource?.onSelect?(viewModel)

        self.wait(for: [OrderListViewControllerTests.selectionPromise!], timeout: timeout)
    }
    
    func testErrorHandling() {
        controller = OrderListViewControllerMock()
        (controller as? OrderListViewControllerMock)?.responseError = true
        OrderListViewControllerTests.presenter?.setView(controller)
        OrderListViewControllerTests.fetchingFailurePromise = expectation(description: "Should notify when fetch fails.")
        controller.loadView()
        controller.viewDidLoad()
        controller.viewDidAppear(true)
        self.wait(for: [OrderListViewControllerTests.fetchingFailurePromise!], timeout: timeout)
    }

}

class OrderListViewControllerMock: OrderListViewController {
    
    public var responseError: Bool = false
    
    override func getAbstractInteractor() -> DKAbstractInteractor? {
        return self
    }
    
    override func updateDataSource(viewModel: [OrderValueViewModel]) {
        super.updateDataSource(viewModel: viewModel)
        XCTAssertEqual(dataSource?.cells.count, 5, "Should have 5 cells")
        OrderListViewControllerTests.fetchingSuccessPromise?.fulfill()
    }
    
    override func getAbstractRouter() -> DKAbstractRouter? {
        return OrderListViewControllerTests.router
    }
    
    override func showError() {
        super.showError()
        OrderListViewControllerTests.fetchingFailurePromise?.fulfill()
    }
}

extension OrderListViewControllerMock: OrderListInteractorProtocol {
    func fetchOrderList() {
        if responseError == false {
            OrderListViewControllerTests.presenter?.processOrders(entity: generateMockList())
        } else {
            OrderListViewControllerTests.presenter?.processOrders(entity: nil)
        }
    }
    
    func setPresenter(_ abstractPresenter: DKAbstractPresenter) {}
    
    
    private func generateMockList() -> OrderListEntity {
        
        var entities: [OrderEntity] = []
        
        for index in 0..<5 {
            let entity = OrderEntity(id: "\(index)", value: Double(index)+0.99, email: "email\(index)@email.com", status: .paid, date: generateMockedDate(), paymentMethod: .credit, buyerName: "", taxes: 0, sandbox: "")
            entities.append(entity)
        }
        
        return OrderListEntity(orderCount: 5, orderTotalValue: 50, orderList: entities)
    }
    
    private func generateMockedDate() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        return dateFormatter.date(from: "20-02-2020") ?? Date()
    }
    
}

class OrderListRouterMock: OrderListRouter {
    override func showDetail(orderID: String) {
        super.showDetail(orderID: orderID)
        XCTAssertNotNil(orderID, "Should have an order ID.")
        OrderListViewControllerTests.selectionPromise?.fulfill()
    }
}
