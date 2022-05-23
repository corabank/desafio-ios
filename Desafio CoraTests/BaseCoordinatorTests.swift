//
//  BaseCoordinatorTests.swift
//  Desafio CoraTests
//
//  Created by João Pedro DTI on 20/05/22.
//

import Desafio_Cora
import Foundation
import UIKit
import XCTest

class MockCoordinator: Coordinator {
    var navigationController: NavigationController
    var parent: Coordinator?
    var childCoordinators: [Coordinator] = []

    var networkServices: NetworkCoordinator?

    init(navigationController: NavigationController) {
        self.navigationController = navigationController
    }

    func start() { }
}

class BaseCoordinatorTests: XCTestCase {

    // swiftlint:disable implicitly_unwrapped_optional
    var window: UIWindow!
    var navigationController: NavigationController!
    var networkServices: NetworkCoordinator!
    // swiftlint:enable implicitly_unwrapped_optional

    override func setUp() {
        super.setUp()
        window = UIWindow()
        window.isHidden = false
        navigationController = NavigationController()
        window.rootViewController = navigationController
    }

    func test_coordinatorChildDidFinish() {
        let mockCoordinator = MockCoordinator(navigationController: navigationController)
        let childCoordinator = MockCoordinator(navigationController: navigationController)
        mockCoordinator.addChild(childCoordinator)
        XCTAssertTrue(mockCoordinator.childCoordinators.count == 1)

        mockCoordinator.removeChild(childCoordinator)
        XCTAssertTrue(mockCoordinator.childCoordinators.isEmpty)
    }
}
