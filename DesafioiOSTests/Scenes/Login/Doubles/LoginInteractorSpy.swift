//
//  LoginInteractorSpy.swift
//  DesafioiOSTests
//
//  Created by Allana Castenharo Santamaria on 04/06/22.
//

import Foundation
@testable import DesafioiOS

typealias LoginInteractorDummy = LoginInteractorSpy

final class LoginInteractorSpy: LoginInteracting {

    let screenType: LoginInteractor.ScreenType
    
    init(screenType: LoginInteractor.ScreenType) {
        self.screenType = screenType
    }
    
    private(set) var validateCalled = false
    func validate(value: String) {
        validateCalled = true
    }
    
    private(set) var nextStepCalled = false
    func nextStep() {
        nextStepCalled = true
    }
    
}
