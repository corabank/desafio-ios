//
//  ReceiptFactory.swift
//  DesafioiOS
//
//  Created by Allana Castenharo Santamaria on 28/05/22.
//

import UIKit

public struct ReceiptFactory {
    static func make() -> UIViewController {
        let coordinator = ReceiptCoordinator()
        let presenter = ReceiptPresenter(coordinator: coordinator)
        let service = ReceiptService()
        let interactor = ReceiptInteractor(service: service, presenter: presenter)
        let viewController = ReceiptViewController(interactor: interactor)
        
        presenter.viewController = viewController
        
        return viewController
    }
}
