//
//  ExtractFactory.swift
//  DesafioiOS
//
//  Created by Allana Castenharo Santamaria on 28/05/22.
//

import UIKit

public struct ExtractFactory {
    static func make() -> UIViewController {
        let coordinator = ExtractCoordinator()
        let presenter = ExtractPresenter(coordinator: coordinator)
        let jsonManager = CoraJsonManager(fileName: "extract-transactions")
        let service = ExtractService(jsonManager: jsonManager)
        let interactor = ExtractInteractor(service: service, presenter: presenter)
        let viewController = ExtractViewController(interactor: interactor)
        
        coordinator.viewController = viewController
        presenter.viewController = viewController
        
        return viewController
    }
}
