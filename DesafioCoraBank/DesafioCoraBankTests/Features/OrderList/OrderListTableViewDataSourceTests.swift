//
//  OrderListTableViewDataSource.swift
//  DesafioCoraBankTests
//
//  Created by Roger Sanoli on 26/04/20.
//  Copyright © 2020 RogerSanoli. All rights reserved.
//

import XCTest
@testable import DungeonKit
@testable import DesafioCoraBank

class OrderListTableViewDataSourceTests: XCTestCase {
    
    private var dataSource: OrderListTableViewDataSource!
    private var tableView: UITableView!
    
    override func setUp() {
        tableView = UITableView()
        dataSource = OrderListTableViewDataSource(tableView)
        dataSource.cells = generateMockViewModels()
    }

    override func tearDown() {
        dataSource = nil
    }
    
    func testDataSource() {
        let cellCount = dataSource.tableView(tableView, numberOfRowsInSection: 0)
        XCTAssertEqual(cellCount, 5, "Should have 5 cells.")
        let firstCell = dataSource.tableView(tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? OrderListTableViewCell
        XCTAssertNotNil(firstCell, "The cell can't be nil.")
        XCTAssertEqual(firstCell?.orderValueView.valueLabel.text, "R$0.99", "The cell should have the correct values.")
    }
    
    func testSelection() {
        var tapped = false
        dataSource.onSelect = { viewModel in
            tapped = true
            XCTAssertNotNil(viewModel, "Should select a View Model.")
        }
        dataSource.tableView(tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
        XCTAssertTrue(tapped, "Should be tapped.")
    }
    
    func testAnimation() {
        let cell = OrderListTableViewCell(frame: .zero)
        dataSource.tableView(tableView, willDisplay: cell, forRowAt: IndexPath(row: 0, section: 0))
        XCTAssertEqual(cell.orderValueView.alpha, 1, "The animation should have started.")
    }
    
    func testAnimationStop() {
        dataSource.scrollViewDidScroll(tableView)
        XCTAssertFalse(dataSource.shouldAnimate, "Should stop animating once moving.")
    }
    
    private func generateMockViewModels() -> [OrderValueViewModel] {
        var viewModels: [OrderValueViewModel] = []
        
        for index in 0..<5 {
            let entity = OrderEntity(id: "\(index)", value: Double(index)+0.99, email: "email\(index)@email.com", status: .paid, date: generateMockedDate(), paymentMethod: .credit, buyerName: "", taxes: 0, sandbox: "")
            let viewModel = OrderValueViewModel(entity)
            viewModels.append(viewModel)
        }
        
        return viewModels
    }
    
    private func generateMockedDate() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        return dateFormatter.date(from: "20-02-2020") ?? Date()
    }
}
