//
//  OrderListPresenterTests.swift
//  DesafioCoraBankTests
//
//  Created by Roger Sanoli on 23/04/20.
//  Copyright © 2020 RogerSanoli. All rights reserved.
//

import XCTest
@testable import DungeonKit
@testable import DesafioCoraBank

class OrderListPresenterTests: XCTestCase {
    
    private var presenter: OrderListPresenter!
    
    private let timeout = 10.0
    private var headerPromise: XCTestExpectation?
    private var cellListPromise: XCTestExpectation?
    private var errorPromise: XCTestExpectation?
    
    override func setUp() {
        presenter = OrderListPresenter()
        presenter.setView(self)
    }
    
    override func tearDown() {
        presenter = nil
    }
    
    func testViewModels() {
        headerPromise = expectation(description: "Should create a consistent header view model.")
        cellListPromise = expectation(description: "Should create a consistent cell list view model.")
        let mockedOrderList = self.generateMockedOrderList()
        self.presenter.processOrders(entity: mockedOrderList)
        self.wait(for: [self.headerPromise!, self.cellListPromise!], timeout: timeout)
    }
    
    func testError() {
        errorPromise = expectation(description: "Should alert view when not able to create a view model.")
        self.presenter.processOrders(entity: nil)
        self.wait(for: [self.errorPromise!], timeout: timeout)
    }
    
    func testFriendlyDates() {
        let minuteSingular = generateMockedDate(years: 0, months: 0, days: 0, hours: 0, minutes: 1)
        let minutePlural = generateMockedDate(years: 0, months: 0, days: 0, hours: 0, minutes: 2)
        let hourSingular = generateMockedDate(years: 0, months: 0, days: 0, hours: 1, minutes: 0)
        let hourPlural = generateMockedDate(years: 0, months: 0, days: 0, hours: 2, minutes: 0)
        let daySingular = generateMockedDate(years: 0, months: 0, days: 1, hours: 0, minutes: 0)
        let dayPlural = generateMockedDate(years: 0, months: 0, days: 2, hours: 0, minutes: 0)
        let weekSingular = generateMockedDate(years: 0, months: 0, days: 8, hours: 0, minutes: 0)
        let weekPlural = generateMockedDate(years: 0, months: 0, days: 15, hours: 0, minutes: 0)
        let monthSingular = generateMockedDate(years: 0, months: 1, days: 0, hours: 0, minutes: 0)
        let monthPlural = generateMockedDate(years: 0, months: 2, days: 0, hours: 0, minutes: 0)
        let yearSingular = generateMockedDate(years: 1, months: 0, days: 0, hours: 0, minutes: 0)
        let yearPlural = generateMockedDate(years: 2, months: 0, days: 0, hours: 0, minutes: 0)
        let justNow = generateMockedDate(years: 0, months: 0, days: 0, hours: 0, minutes: 0)
        let future = generateMockedDate(years: 0, months: 0, days: 0, hours: 0, minutes: -1)
        
        XCTAssertEqual(minuteSingular.friendlyDescription(), "1 minute ago", "Dates should have the correct friendly description.")
        XCTAssertEqual(minutePlural.friendlyDescription(), "2 minutes ago", "Dates should have the correct friendly description.")
        XCTAssertEqual(hourSingular.friendlyDescription(), "1 hour ago", "Dates should have the correct friendly description.")
        XCTAssertEqual(hourPlural.friendlyDescription(), "2 hours ago", "Dates should have the correct friendly description.")
        XCTAssertEqual(daySingular.friendlyDescription(), "1 day ago", "Dates should have the correct friendly description.")
        XCTAssertEqual(dayPlural.friendlyDescription(), "2 days ago", "Dates should have the correct friendly description.")
        XCTAssertEqual(weekSingular.friendlyDescription(), "1 week ago", "Dates should have the correct friendly description.")
        XCTAssertEqual(weekPlural.friendlyDescription(), "2 weeks ago", "Dates should have the correct friendly description.")
        XCTAssertEqual(monthSingular.friendlyDescription(), "1 month ago", "Dates should have the correct friendly description.")
        XCTAssertEqual(monthPlural.friendlyDescription(), "2 months ago", "Dates should have the correct friendly description.")
        XCTAssertEqual(yearSingular.friendlyDescription(), "1 year ago", "Dates should have the correct friendly description.")
        XCTAssertEqual(yearPlural.friendlyDescription(), "2 years ago", "Dates should have the correct friendly description.")
        XCTAssertEqual(justNow.friendlyDescription(), "just now", "59 seconds or less should be considered just now.")
        XCTAssertEqual(future.friendlyDescription(), "just now", "Future dates should be represented as now.")
    }
    
    private func generateMockedOrderList() -> OrderListEntity {
        var mock = OrderListEntity()
        mock.orderCount = 320
        mock.orderTotalValue = 115345.45
        
        var order1 = OrderEntity()
        order1.id = "1"
        order1.value = 100.10
        order1.email = "email1@email.com"
        order1.date = generateMockedDate(years: 0, months: 0, days: 0, hours: 0, minutes: 15)
        order1.status = .paid
        
        var order2 = OrderEntity()
        order2.id = "2"
        order2.value = 200.20
        order2.email = "email2@email.com"
        order2.date = generateMockedDate(years: 0, months: 0, days: 2, hours: 9, minutes: 15)
        order2.status = .waiting
        
        var order3 = OrderEntity()
        order3.id = "3"
        order3.value = 300.30
        order3.email = "email3@email.com"
        order3.date = generateMockedDate(years: 0, months: 3, days: 2, hours: 9, minutes: 15)
        order3.status = .notpaid
        
        mock.orderList = [order1, order2, order3]
        
        return mock
    }
    
    private func generateMockedDate(years: Int, months: Int, days: Int, hours: Int, minutes: Int) -> Date {
        let gregorian  = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)
        var offsetComponents = DateComponents()
        offsetComponents.year = years * -1
        offsetComponents.month = months * -1
        offsetComponents.day = days * -1
        offsetComponents.hour = hours * -1
        offsetComponents.minute = minutes * -1
        
        let date = gregorian?.date(byAdding: offsetComponents, to: Date(), options: .init(rawValue: 0) )
        return date ?? Date()
    }
}

extension OrderListPresenterTests: OrderListViewControllerProtocol {
    func updateHeader(viewModel: OrderListHeaderViewModel) {
        let subtitle = "320 orders, adding up to R$ 115345.45"
        XCTAssertEqual(viewModel.subtitle.string, subtitle, "Subtitle should be built correctly.")
        headerPromise?.fulfill()
    }
    
    func updateOrderList(viewModel: [OrderValueViewModel]) {
        
        XCTAssertNotNil(viewModel, "Should have a View Model list.")
        XCTAssertFalse(viewModel.isEmpty, "The list should not be empty.")
        XCTAssertEqual(viewModel.count, 3, "Should have three elements.")
        
        let cell1 = viewModel[0]
        let cell2 = viewModel[1]
        let cell3 = viewModel[2]
        
        XCTAssertNotNil(cell1.iconImageName, "Should have an icon.")
        XCTAssertEqual(cell1.value, "R$100.10", "Should format the value.")
        XCTAssertEqual(cell1.subtitle, "email1@email.com", "Should present the email on subtitle.")
        XCTAssertEqual(cell1.status, "Paid", "Status should be set as Paid.")
        XCTAssertEqual(cell1.statusColor, .cbGreen, "Status color should be green.")
        XCTAssertEqual(cell1.friendlyDate, "15 minutes ago", "Date should be formatted correctly.")
        
        XCTAssertNotNil(cell2.iconImageName, "Should have an icon.")
        XCTAssertEqual(cell2.value, "R$200.20", "Should format the value.")
        XCTAssertEqual(cell2.subtitle, "email2@email.com", "Should present the email on subtitle.")
        XCTAssertEqual(cell2.status, "Waiting", "Status should be set as Waiting.")
        XCTAssertEqual(cell2.statusColor, .cbLightBlue, "Status color should be light blue.")
        XCTAssertEqual(cell2.friendlyDate, "2 days ago", "Date should be formatted correctly.")
        
        XCTAssertNotNil(cell3.iconImageName, "Should have an icon.")
        XCTAssertEqual(cell3.value, "R$300.30", "Should format the value.")
        XCTAssertEqual(cell3.subtitle, "email3@email.com", "Should present the email on subtitle.")
        XCTAssertEqual(cell3.status, "Not Paid", "Status should be set as Not Paid.")
        XCTAssertEqual(cell3.statusColor, .cbRed, "Status color should be red.")
        XCTAssertEqual(cell3.friendlyDate, "3 months ago", "Date should be formatted correctly.")
        
        cellListPromise?.fulfill()
    }
    
    func alertErrorLoadingData() {
        errorPromise?.fulfill()
    }
    
    func setInteractor(_ abstractInteractor: DKAbstractInteractor) {}
}
