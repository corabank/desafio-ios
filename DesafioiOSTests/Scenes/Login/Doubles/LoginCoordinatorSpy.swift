//
//  LoginCoordinatorSpy.swift
//  DesafioiOSTests
//
//  Created by Allana Castenharo Santamaria on 05/06/22.
//

import Foundation
@testable import DesafioiOS

typealias LoginCoordinatorDummy = LoginCoordinatorSpy

final class LoginCoordinatorSpy: LoginCoordinating {
    private(set) var showPasswordCalled = false
    func showPassword() {
        showPasswordCalled = true
    }
    
    private(set) var showExtractCalled = false
    func showExtract() {
        showExtractCalled = true
    }
}

