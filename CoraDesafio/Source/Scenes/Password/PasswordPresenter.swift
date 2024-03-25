//
//  PasswordPresenter.swift
//  CoraDesafio
//
//  Created by Erik Santos on 14/03/24.
//

import Foundation
import NetwokKit

protocol PasswordPresenting: AnyObject {
    var viewController: PasswordDisplaying? { get set }
    
    func didPop()
    func setEnableButton(_ value: Bool)
    func showExtractView(service: CoraServicing)
    func startLoadingButton()
    func stopLoadingButton()
}

final class PasswordPresenter {
    
    // MARK: - Properties
    
    weak var viewController: PasswordDisplaying?
    private let coordinator: OnboardingCoordinating
    
    // MARK: - Initialize
    
    init(coordinator: OnboardingCoordinating) {
        self.coordinator = coordinator
    }
}

// MARK: - PasswordPresenting

extension PasswordPresenter: PasswordPresenting {
    func startLoadingButton() {
        viewController?.startLoadingButton()
    }
    
    func stopLoadingButton() {
        viewController?.stopLoadingButton()
    }
    
    func setEnableButton(_ value: Bool) {
        viewController?.setEnableButton(value)
    }
    
    func showExtractView(service: CoraServicing) {
        stopLoadingButton()
        coordinator.perform(to: .extract(service))
    }
    
    func didPop() {
        coordinator.pop()
    }
}
