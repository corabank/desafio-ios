//
//  OnboardingInteractor.swift
//  CoraDesafio
//
//  Created by Erik Santos on 14/03/24.
//

import Foundation

protocol OnboardingInteracting: AnyObject {
    func showLoginView()
    func showRegisterView()
}

final class OnboardingInteractor {
    
    // MARK: - Properties

    private let presenter: OnboardingPreseting
    
    // MARK: - Initialize
    
    init(presenter: OnboardingPreseting) {
        self.presenter = presenter
    }
}

// MARK: - OnboardingInteracting

extension OnboardingInteractor: OnboardingInteracting {
    func showLoginView() {
        presenter.presentLoginView()
    }
    
    func showRegisterView() {
        presenter.presentRegisterView()
    }
}
