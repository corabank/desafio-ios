//
//  OnboardingPresenter.swift
//  CoraDesafio
//
//  Created by Erik Santos on 14/03/24.
//

import Foundation

protocol OnboardingPreseting: AnyObject {
    var viewController: OnboardingViewDisplaying? { get set }
    
    func presentLoginView()
    func presentRegisterView()
}

final class OnboardingPresenter {
    
    // MARK: - Properties
    
    weak var viewController: OnboardingViewDisplaying?
    private let coordinator: OnboardingCoordinating
    
    // MARK: - Initialize
    
    init(coordinator: OnboardingCoordinating) {
        self.coordinator = coordinator
    }
}

// MARK: - OnboardingPreseting

extension OnboardingPresenter: OnboardingPreseting {
    func presentLoginView() {
        coordinator.perform(to: .login)
    }
    
    func presentRegisterView() {
        coordinator.perform(to: .register)
    }
}
