//
//  OnboardingPresenterSpy.swift
//  CoraDesafioTests
//
//  Created by Erik Santos on 24/03/24.
//

import Foundation
@testable import CoraDesafio

final class OnboardingPresenterSpy: OnboardingPreseting {
    
    var viewController: OnboardingViewDisplaying?
    
    var presentLoginViewCalled = 0
    func presentLoginView() {
        presentLoginViewCalled = 1
    }
    
    var presentRegisterViewCalled = 0
    func presentRegisterView() {
        presentRegisterViewCalled = 1
    }
}
