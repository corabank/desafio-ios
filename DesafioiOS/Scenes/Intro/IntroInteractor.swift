//
//  IntroInteractor.swift
//  DesafioiOS
//
//  Created by Allana Castenharo Santamaria on 27/05/22.
//

import Foundation

protocol IntroInteracting: AnyObject {
    func openLogin()
}

final class IntroInteractor: CoraInteractor<IntroPresenting> { }

extension IntroInteractor: IntroInteracting {
    func openLogin() {
        presenter.presentLogin()
    }
}
