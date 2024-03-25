//
//  PasswordPresenterSpy.swift
//  CoraDesafioTests
//
//  Created by Erik Santos on 24/03/24.
//

import Foundation
import NetwokKit
@testable import CoraDesafio

final class PasswordPresenterSpy: PasswordPresenting {
    var viewController: PasswordDisplaying?
    
    var didPopCalled = 0
    func didPop() {
        didPopCalled = 1
    }
    
    var setEnableButtonValue = false
    var setEnableButtonCalled = 0
    func setEnableButton(_ value: Bool) {
        setEnableButtonCalled = 1
        setEnableButtonValue = value
    }
    
    var showExtractViewCalled = 0
    func showExtractView(service: CoraServicing) {
        showExtractViewCalled = 1
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
