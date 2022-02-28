//
//  TransactionsListCoordinatorTests.swift
//  DesafioCoraTests
//
//  Created by user205543 on 2/27/22.
//

import XCTest
@testable import DesafioCora

class TransactionsListCoordinatorTests: XCTestCase {
    let mockViewController = ViewControllerMock()
    
    lazy var sut: TransactionsListCoordinator = {
        let coordinator = TransactionsListCoordinator()
        coordinator.viewController = mockViewController
        return coordinator
    }()
    
    func testPerform_WhenActionIsDetail_ShouldPresentDetailViewController() {
        let model = TransactionModel(value: 110, userName: "Caju Cacau", userEmail: "caju@mail.com", paymentStatus: .paid, paymentType: .creditCard, transactionDate: Date(), tax: 10, id: "abcdEFGH1234")
        sut.perform(action: .detail(model))
        
        let navigation = mockViewController.presentedVC as? UINavigationController
        XCTAssertTrue(navigation?.topViewController is TransactionDetailsVewController)
    }
}
