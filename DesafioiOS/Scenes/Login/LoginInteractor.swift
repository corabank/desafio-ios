//
//  LoginInteractor.swift
//  DesafioiOS
//
//  Created by Allana Castenharo Santamaria on 28/05/22.
//

import UIKit

protocol LoginInteracting: AnyObject {
    var screenType: LoginInteractor.ScreenType { get }
    func validate(value: String)
    func nextStep()
}

final class LoginInteractor: CoraInteractor<LoginPresenting> {
    let screenType: ScreenType
    
    init(screenType: ScreenType, presenter: LoginPresenting) {
        self.screenType = screenType
        super.init(presenter: presenter)
    }
}

extension LoginInteractor: LoginInteracting {
    func validate(value: String ) {
        
        guard let pattern = screenType.regex,
              let regex = try? NSRegularExpression(pattern: pattern, options: []) else {
            presenter.presentValidation(isValid: !value.isEmpty)
            return
        }
        let range = NSRange(location: 0, length: value.count)
        let isvalid = regex.matches(in: value, options: [], range: range).count == 1
        presenter.presentValidation(isValid: isvalid)
    }
    
    func nextStep() {
        switch screenType {
        case .cpf:
            presenter.presentPassordView()
        case .password:
            presenter.presentExtract()
            break
        }
    }
}

extension LoginInteractor {
    enum ScreenType {
        case cpf
        case password
        
        var regex: String? {
            switch self {
            case .cpf:
                return "([0-9]{2}[\\.]?[0-9]{3}[\\.]?[0-9]{3}[\\/]?[0-9]{4}[-]?[0-9]{2})|([0-9]{3}[\\.]?[0-9]{3}[\\.]?[0-9]{3}[-]?[0-9]{2})"
            case .password:
                return nil
            }
        }
    }
}
