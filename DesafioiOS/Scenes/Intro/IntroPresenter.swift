//
//  IntroPresenter.swift
//  DesafioiOS
//
//  Created by Allana Castenharo Santamaria on 27/05/22.
//

import Foundation

protocol IntroPresenting: AnyObject {
    func presentLogin()
}

final class IntroPresenter: CoraPresenter<IntroCoordinating> { }

extension IntroPresenter: IntroPresenting {
    func presentLogin() {
        coordinator.showLogin()
    }
}
