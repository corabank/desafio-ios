//
//  OrdersListUITests.swift
//  coraUITests
//
//  Created by Lucas Silveira on 24/04/21.
//

import XCTest

class OrdersUITests: XCTestCase {
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
            if tableView.isEnabled {
                XCTAssert(tableView.cells.count >= 100)
                
                tableView.cells.firstMatch.tap()
                let backButton = self.app.buttons["backButton"]
                
                if backButton.waitForExistence(timeout: 10) {
                    backButton.tap()
                    XCTAssertFalse(backButton.exists)
                }
                return true
            } else {
                return false
            }
        }
        waitForExpectations(timeout: 40, handler: nil)
    }
    
    func testScrollingOrdersList() {
        MakeLogin.run(app: app)
        
        let tableView = app.tables["ordersTableView"]
        if app.waitForExistenceOfAll(elements: [tableView], for: 30) {
            if tableView.isEnabled {
                let firstCell = tableView.cells["order1"]
                let lastCell = tableView.cells["order99"]
                
                while lastCell.isHittable == false {
                    self.app.swipeUp(velocity: .fast)
                }
                
                XCTAssertFalse(firstCell.isHittable)
                XCTAssertTrue(lastCell.isHittable)
                
                while firstCell.isHittable == false {
                    self.app.swipeDown(velocity: .fast)
                }
                
                XCTAssertFalse(lastCell.isHittable)
                XCTAssertTrue(firstCell.isHittable)
                
            }
        }
    }
}
