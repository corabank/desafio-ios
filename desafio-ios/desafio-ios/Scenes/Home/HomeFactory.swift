//
//  HomeFactory.swift
//  desafio-ios
//
//  Created by Barbara Barone on 08/02/22.
//

import UIKit

enum HomeFactory {
    static func make() -> UIViewController {
        let service: HomeServicing = HomeService()
        let presenter: HomePresenting = HomePresenter()
        let interactor = HomeInteractor(service: service, presenter: presenter)
        let viewController = HomeViewController(interactor: interactor)

        presenter.viewController = viewController

        return viewController
    }
}
