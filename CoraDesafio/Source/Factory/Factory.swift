//
//  Factory.swift
//  CoraDesafio
//
//  Created by Erik Santos on 14/03/24.
//

import Foundation
import UIKit
import NetwokKit
import SwiftUI

// MARK: - Open Onboarding

enum OnboardingFactory {
    static func make() -> UIViewController {
        
        let coordinator: OnboardingCoordinating = OnboardingCoordinator()
        let presenter: OnboardingPreseting = OnboardingPresenter(coordinator: coordinator)
        let interactor: OnboardingInteracting = OnboardingInteractor(presenter: presenter)
        let viewController = OnboadingViewController(interactor: interactor)
        
        coordinator.viewController = viewController
        presenter.viewController = viewController
        
        return viewController
    }
}

// MARK: - Open Login

enum LoginFactory {
    static func make(coordinator: OnboardingCoordinating) -> UIViewController {
    
        let presenter: LoginPresenting = LoginPresenter(coordinator: coordinator)
        let interactor: LoginInteracting = LoginInteractor(presenter: presenter)
        let viewController = LoginViewController(interactor: interactor)
        
        presenter.viewController = viewController
        
        return viewController
    }
}

// MARK: - Open Password

enum PasswordFactory {
    static func make(coordinator: OnboardingCoordinating) -> UIViewController {
    
        let service: CoraServicing = CoraService()
        let presenter: PasswordPresenting = PasswordPresenter(coordinator: coordinator)
        let interactor: PasswordInteracting = PasswordInteractor(presenter: presenter, service: service)
        let viewController = PasswordViewController(interactor: interactor)
        
        presenter.viewController = viewController
        
        return viewController
    }
}

// MARK: - Open Extract

enum ExtractFactory {
    static func make(coordinator: OnboardingCoordinating, service: CoraServicing) -> UIViewController {
        let viewModel = ExtractListViewModel(service: service)
        let controller = UIHostingController(rootView: ExtractListView(viewModel))
        
        viewModel.coordinator = coordinator
        
        return controller
    }
}
