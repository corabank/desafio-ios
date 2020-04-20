//
//  LoginView.swift
//  DesafioCoraBank
//
//  Created by Roger Sanoli on 20/04/20.
//  Copyright © 2020 RogerSanoli. All rights reserved.
//

import Foundation
import UIKit

final class LoginView: UIView {
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LoginView: CodeView {
    func buildViewHierarchy() {
       
    }
    
    func setupConstraints() {
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupAdditionalConfiguration() {

    }
}
