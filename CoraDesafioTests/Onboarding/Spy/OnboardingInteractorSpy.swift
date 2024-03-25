//
//  File.swift
//  CoraDesafioTests
//
//  Created by Erik Santos on 24/03/24.
//

import Foundation
@testable import CoraDesafio

final class OnboardingInteractorSpy: OnboardingInteracting {
    
    var presenterSpy = OnboardingPresenterSpy()

    var showLoginViewCalled = 0
    func showLoginView() {
        showLoginViewCalled = 1
        presenterSpy.presentLoginView()
    }
    
    var showRegisterViewCalled = 0
    func showRegisterView() {
        showRegisterViewCalled = 1
        presenterSpy.presentRegisterView()
    }
}
