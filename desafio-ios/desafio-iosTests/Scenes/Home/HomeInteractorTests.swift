//
//  HomeInteractorTests.swift
//  desafio-iosTests
//
//  Created by Barbara Barone on 14/02/22.
//

import XCTest
@testable import desafio_ios

private final class HomeServiceMock: HomeServicing {
    func readLocalFile(forName name: String) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: name,  ofType: "json"),
               let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error)
        }
        return nil
    }
    
    func parse(jsonData: Data) -> Product? {
        do {
            let decodedData = try JSONDecoder().decode(Product.self, from: jsonData)
            return decodedData
        } catch {
            print("decode error")
        }
        return nil
    }
}

private final class HomePresenterMock: HomePresenting {
    var viewController: HomeDisplaying?
    
    private(set) var presentCallsCount = 0
    
    private(set) var presentReceivedInvocations: [ProductItem]?
    
    func present(products: [ProductItem]) {
        presentReceivedInvocations = products
        presentCallsCount += 1
    }
}

final class HomeInteractorTests: XCTestCase {
    private let service = HomeServiceMock()
    private let presenter = HomePresenterMock()
    
    private lazy var sut: HomeInteracting = HomeInteractor(service: service, presenter: presenter)
    
    func testLoad_ShouldPresentData() {
        let products = [ProductItem(value: 630.00, description: "Spider Armor MK I", date: "20/02/2022"),
                        ProductItem(value: 500.00, description: "Amazing Fantasy", date: "05/01/2021"),
                        ProductItem(value: 900.00, description: "Black Costume", date: "15/03/2015"),
                        ProductItem(value: 1000.00, description: "Symbiote Suit", date: "05/06/2019"),
                        ProductItem(value: 800.99, description: "Bombastic Bag-Man's", date: "07/10/1999"),
                        ProductItem(value: 999.99, description: "Black Cloth Suit", date: "03/04/2020"),
                        ProductItem(value: 5555.00, description: "Captain Universe's Suit", date: "05/07/2007"),
                        ProductItem(value: 444.00, description: "Electro-Proof Suit", date: "25/11/2001")]
        
        sut.load()
        
        XCTAssertEqual(presenter.presentReceivedInvocations, products)
        XCTAssertEqual(presenter.presentCallsCount, 1)
    }
}
