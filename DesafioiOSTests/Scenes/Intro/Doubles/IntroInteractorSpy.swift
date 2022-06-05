//
//  IntroInteractorSpy.swift
//  DesafioiOSTests
//
//  Created by Allana Castenharo Santamaria on 04/06/22.
//

import Foundation
@testable import DesafioiOS

final class IntroInteractorSpy: IntroInteracting {
    private(set) var openRegisterCalled = false
    func openRegister() {
        openRegisterCalled = true
    }
    
    private(set) var openLoginCalled = false
    func openLogin() {
        openLoginCalled = true
    }
}
