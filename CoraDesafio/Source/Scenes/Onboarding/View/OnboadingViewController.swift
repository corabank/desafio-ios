//
//  OnboadingViewController.swift
//  CoraDesafio
//
//  Created by Erik Santos on 14/03/24.
//

import UIKit
import DesignKit
import CoreKit
import NetwokKit

protocol OnboardingViewDisplaying: AnyObject {
    /* Intentionaly Implemented */
}

class OnboadingViewController: BaseViewController<OnboardingInteracting, OnboardingView> {
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegates()
        prepareView()
    }
    
    // MARK: - Private Methods
    
    private func prepareView() {
        rootView.backgroundColor = CoraAssets.defaultPinkColor.color
        navigationCora.isHidden = true
    }
    
    private func setupDelegates() {
        rootView.delegate = self
    }
}

// MARK: - Delegate

extension OnboadingViewController: OnboadingViewDelegate, OnboardingViewDisplaying {
    func didTapLogin(_ button: CoraButtonView) {
        interactor.showLoginView()
    }
    
    func didTapRegister(_ button: CoraButtonView) {
        interactor.showRegisterView()
    }
}
