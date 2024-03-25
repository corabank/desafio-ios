//
//  OnboardingCoordinator.swift
//  CoraDesafio
//
//  Created by Erik Santos on 14/03/24.
//

import Foundation
import UIKit
import SwiftUI
import NetwokKit

typealias OnboardingCoordinatorFlow = OnboardingCoordinator.CoordinatorFlow

protocol OnboardingCoordinating: AnyObject {
    var viewController: UIViewController? { get set }
    
    func perform(to flow: OnboardingCoordinatorFlow)
    func pop()
}

final class OnboardingCoordinator {
    
    // MARK: - Properties
    
    weak var viewController: UIViewController?
}

// MARK: - OnboardingCoordinating

extension OnboardingCoordinator: OnboardingCoordinating {
    func pop() {
        viewController?.navigationController?.popViewController(animated: true)
    }
    
    func perform(to flow: CoordinatorFlow) {
        switch flow {
        case .login:
            let controller = LoginFactory.make(coordinator: self)
            viewController?.navigationController?.pushViewController(controller, animated: true)
        case .register:
            print("Registro")
            /* Intentionaly Implemented */
        case .password:
            let controller = PasswordFactory.make(coordinator: self)
            viewController?.navigationController?.pushViewController(controller, animated: true)
        case let .extract(service):
            let controller = ExtractFactory.make(coordinator: self, service: service)
            viewController?.navigationController?.pushViewController(controller, animated: true)
        case .onbarding:
            viewController?.navigationController?.popToRootViewController(animated: true)
        }
    }
}

// MARK: - CoordinatorFlow

extension OnboardingCoordinator {
    enum CoordinatorFlow: Equatable {
        
        case login
        case register
        case password
        case extract(CoraServicing)
        case onbarding
        
        
        var getId: String {
            switch self {
            case .login:
                return "LOGIN"
            case .register:
                return "REGISTER"
            case .password:
                return "PASSWORD"
            case .extract:
                return "EXTRACT"
            case .onbarding:
                return "ONBOARDING"
            }
        }
        
        static func == (lhs: OnboardingCoordinator.CoordinatorFlow, rhs: OnboardingCoordinator.CoordinatorFlow) -> Bool {
            lhs.getId == rhs.getId
        }
    }
}
