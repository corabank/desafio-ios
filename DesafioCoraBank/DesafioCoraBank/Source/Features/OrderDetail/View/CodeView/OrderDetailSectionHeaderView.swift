//
//  OrderDetailSectionHeaderView.swift
//  DesafioCoraBank
//
//  Created by Roger Sanoli on 24/04/20.
//  Copyright © 2020 RogerSanoli. All rights reserved.
//

import Foundation
import UIKit

final class OrderDetailSectionHeaderView: UIView {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .cbDarkGray
        label.font = .cbRegular(12)
        label.isAccessibilityElement = false
        return label
    }()
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    public func setup(_ viewModel: OrderDetailSectionHeaderViewModel) {
        titleLabel.text = viewModel.sectionTitle
        self.accessibilityLabel = viewModel.sectionTitle
        self.accessibilityValue = viewModel.sectionTitle
        self.accessibilityTraits = .staticText
    }
}

extension OrderDetailSectionHeaderView: CodeView {
    func buildViewHierarchy() {
        self.addSubview(titleLabel)
    }
    
    func setupConstraints() {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: .cbLeftMargin).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: .cbRightMargin).isActive = true
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = .cbLightGray
        self.isAccessibilityElement = true
    }
}
