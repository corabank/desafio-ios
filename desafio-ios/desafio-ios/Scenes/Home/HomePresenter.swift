//
//  HomePresenting.swift
//  desafio-ios
//
//  Created by Barbara Barone on 08/02/22.
//

import Foundation

protocol HomePresenting: AnyObject {
    var viewController: HomeDisplaying? { get set }
    func present(products: [ProductItem])
}

final class HomePresenter {

    weak var viewController: HomeDisplaying?

    init() { }
}

// MARK: - HomePresenting
extension HomePresenter: HomePresenting {
    func present(products: [ProductItem]) {
        viewController?.set(products: products)
    }
}

