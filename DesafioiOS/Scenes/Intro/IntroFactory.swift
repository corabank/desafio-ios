//
//  IntroFactory.swift
//  DesafioiOS
//
//  Created by Allana Castenharo Santamaria on 27/05/22.
//

import UIKit

public struct IntroFactory {
    static func make() -> UIViewController {
        let coordinator = IntroCoordinator()
        let presenter = IntroPresenter(coordinator: coordinator)
        let interactor = IntroInteractor(presenter: presenter)
        let viewController = IntroViewController(interactor: interactor)
        
        coordinator.viewController = viewController
        
        return viewController
    }
}
