//
//  OnboardingCoordinatorSpr.swift
//  CoraDesafioTests
//
//  Created by Erik Santos on 24/03/24.
//

import Foundation
import UIKit
@testable import CoraDesafio

final class OnboardingCoordinatorSpy: OnboardingCoordinating {
    
    var viewController: UIViewController?
    
    var performCalledValue: OnboardingCoordinatorFlow?
    var performCalled = 0
    func perform(to flow: OnboardingCoordinatorFlow) {
        performCalled = 1
        performCalledValue = flow
    }
    
    var popCalled = 0
    func pop() {
        popCalled = 1
    }
}
