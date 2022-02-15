//
//  HomePresenterTests.swift
//  desafio-iosTests
//
//  Created by Barbara Barone on 15/02/22.
//

import XCTest
@testable import desafio_ios

private final class HomeViewControllerSpy: HomeDisplaying {
    private(set) var setCallsCount = 0
    
    private(set) var setReceivedInvocation: [ProductItem]?
    
    func set(products: [ProductItem]) {
        setReceivedInvocation = products
        setCallsCount += 1
    }
}

final class HomePresenterTests: XCTestCase {
    private let viewControllerSpy = HomeViewControllerSpy()
    
    private lazy var sut: HomePresenting = {
        let presenter = HomePresenter()
        presenter.viewController = viewControllerSpy
        return presenter
    }()
    
    func testPresent_WhenLoadProducts_ShouldShowProductsScreen() {
        let products = [ProductItem(value: 630.00, description: "Spider Armor MK I", date: "20/02/2022"),
                        ProductItem(value: 500.00, description: "Amazing Fantasy", date: "05/01/2021"),
                        ProductItem(value: 900.00, description: "Black Costume", date: "15/03/2015"),
                        ProductItem(value: 1000.00, description: "Symbiote Suit", date: "05/06/2019"),
                        ProductItem(value: 800.99, description: "Bombastic Bag-Man's", date: "07/10/1999"),
                        ProductItem(value: 999.99, description: "Black Cloth Suit", date: "03/04/2020"),
                        ProductItem(value: 5555.00, description: "Captain Universe's Suit", date: "05/07/2007"),
                        ProductItem(value: 444.00, description: "Electro-Proof Suit", date: "25/11/2001")]
        
        sut.present(products: products)
        
        XCTAssertEqual(viewControllerSpy.setReceivedInvocation, products)
        XCTAssertEqual(viewControllerSpy.setCallsCount, 1)
    }
}
