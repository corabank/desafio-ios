//
//  ViewConfiguration.swift
//  desafio-ios
//
//  Created by Barbara Barone on 08/02/22.
//

import Foundation

protocol ViewConfiguration {
    func buildViewHierarchy()
    func setupConstraints()
    func configureViews()
}

extension ViewConfiguration {
    func buildLayout() {
        buildViewHierarchy()
        setupConstraints()
        configureViews()
    }
}
