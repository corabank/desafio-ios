//
//  CodeView.swift
//  DesafioCoraBank
//
//  Created by Roger Sanoli on 19/04/20.
//  Copyright © 2020 RogerSanoli. All rights reserved.
//

import Foundation

public protocol CodeView {
    func buildViewHierarchy()
    func setupConstraints()
    func setupAdditionalConfiguration()
    func setupView()
}

extension CodeView {
    func setupView() {
        buildViewHierarchy()
        setupConstraints()
        setupAdditionalConfiguration()
    }
}
