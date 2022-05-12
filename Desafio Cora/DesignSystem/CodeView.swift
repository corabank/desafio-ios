//
//  CodeView.swift
//  Desafio Cora
//
//  Created by João Pedro DTI on 11/05/22.
//

import Foundation

protocol CodeView {
    func buildViewHierarchy()
    func setupConstraints()
    func setupAdditionalConfigaration()
    func setupView()
}

extension CodeView {
    func setupView() {
        buildViewHierarchy()
        setupConstraints()
        setupAdditionalConfigaration()
    }
}
