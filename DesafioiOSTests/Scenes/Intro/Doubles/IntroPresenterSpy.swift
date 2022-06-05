//
//  IntroPresenterSpy.swift
//  DesafioiOSTests
//
//  Created by Allana Castenharo Santamaria on 05/06/22.
//

import Foundation
@testable import DesafioiOS

class IntroPresenterSpy: IntroPresenting {
    enum Message: Equatable {
        case presentRegister
        case presentLogin
    }

    private(set) var receivedMessages: [Message] = []

    func presentRegister() {
        receivedMessages.append(.presentRegister)
    }

    func presentLogin() {
        receivedMessages.append(.presentLogin)
    }
}
