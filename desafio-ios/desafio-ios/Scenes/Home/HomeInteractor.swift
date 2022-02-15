//
//  HomeInteractor.swift
//  desafio-ios
//
//  Created by Barbara Barone on 08/02/22.
//

import Foundation

protocol HomeInteracting: AnyObject {
    /**
     * Load products
     *
     * It will manager what should be done when loading a products:
     *   - Show loaded products
     *
     */
    func load()
}

final class HomeInteractor {
    
    private let service: HomeServicing
    private let presenter: HomePresenting
    
    init(service: HomeServicing, presenter: HomePresenting) {
        self.service = service
        self.presenter = presenter
    }
}

// MARK: - HomeInteracting
extension HomeInteractor: HomeInteracting {
    func load() {
        guard let jsonData = service.readLocalFile(forName: "Products") else { return }
        guard let product = service.parse(jsonData: jsonData) else { return }
        presenter.present(products: product.products)
    }
}
