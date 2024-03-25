//
//  PasswordViewControllerSpy.swift
//  CoraDesafioTests
//
//  Created by Erik Santos on 24/03/24.
//

import Foundation
@testable import CoraDesafio

final class PasswordViewControllerSpy: PasswordDisplaying {
    
    var setEnableButtonValue = false
    var setEnableButtonCalled = 0
    func setEnableButton(_ value: Bool) {
        setEnableButtonCalled = 1
        setEnableButtonValue = value
    }
    
    var startLoadingButtonCalled = 0
    func startLoadingButton() {
        startLoadingButtonCalled = 1
    }
    
    var stopLoadingButtonCalled = 0
    func stopLoadingButton() {
        stopLoadingButtonCalled = 1
    }
}
