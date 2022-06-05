//
//  ViewCode.swift
//  DesafioiOS
//
//  Created by Allana Castenharo Santamaria on 26/05/22.
//

import UIKit

public protocol ViewCode: AnyObject {
    func buildViewHierarchy()
    func setupConstraints()
    func setupAdditionalConfiguration()
    func setupView()
}

public extension ViewCode {
    func setupView() {
        buildViewHierarchy()
        setupConstraints()
        setupAdditionalConfiguration()
    }
    
    func buildViewHierarchy() { }
    func setupConstraints() { }
    func setupAdditionalConfiguration() { }
}
