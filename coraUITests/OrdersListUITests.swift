//
//  OrdersListUITests.swift
//  coraUITests
//
//  Created by Lucas Silveira on 24/04/21.
//

import XCTest

class OrdersListUITests: XCTestCase {
    var app: XCUIApplication!
    
    // MARK: - XCTestCase
    
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments.append("--uitesting")
    }
    
    func testGoingThroughOrdersAndListShouldBeLoaded() {
        MakeLogin.run(app: app)
        
        let tableView = app.tables["ordersTableView"]
        let exists = NSPredicate(format: "exists == TRUE")
        expectation(for: exists, evaluatedWith: tableView) {
            // If the table view exists, also check that it is enabled
            if tableView.isEnabled {
                XCTAssert(tableView.cells.count >= 100)
                return true
            } else {
                // Do not fulfill the expectation since the table view is not enabled
                return false
            }
        }
        waitForExpectations(timeout: 40, handler: nil)
    }
}
