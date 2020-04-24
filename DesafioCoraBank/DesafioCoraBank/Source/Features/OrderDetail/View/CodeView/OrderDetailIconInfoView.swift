//
//  OrderDetailIconInfoView.swift
//  DesafioCoraBank
//
//  Created by Roger Sanoli on 24/04/20.
//  Copyright © 2020 RogerSanoli. All rights reserved.
//

import Foundation
import UIKit

final class OrderDetailIconInfoView: UIView {
    
    private lazy var iconImage: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .cbLightBlue
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var fieldLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .cbDarkGray
        label.font = .cbRegular(12)
        return label
    }()
    
    private lazy var valueLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .cbBlack
        label.font = .cbRegular(14)
        return label
    }()
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    public func setup(_ viewModel: OrderDetailIconInfoViewModel) {
        iconImage.image = UIImage(named: viewModel.iconImageName)
        fieldLabel.text = viewModel.fieldText
        valueLabel.text = viewModel.valueText
        valueLabel.textColor = viewModel.valueColor
    }
}

extension OrderDetailIconInfoView: CodeView {
    func buildViewHierarchy() {
        self.addSubview(iconImage)
        self.addSubview(fieldLabel)
        self.addSubview(valueLabel)
    }
    
    func setupConstraints() {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        iconImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: .cbLeftMargin).isActive = true
        iconImage.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        iconImage.heightAnchor.constraint(equalToConstant: 20).isActive = true
        iconImage.widthAnchor.constraint(equalToConstant: 20).isActive = true
        
        fieldLabel.leadingAnchor.constraint(equalTo: iconImage.trailingAnchor, constant: .cbLeftMargin).isActive = true
        fieldLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: .cbRightMargin).isActive = true
        fieldLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: .cbTopMargin).isActive = true
        fieldLabel.heightAnchor.constraint(equalToConstant: 14).isActive = true
        
        valueLabel.leadingAnchor.constraint(equalTo: iconImage.trailingAnchor, constant: .cbLeftMargin).isActive = true
        valueLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: .cbRightMargin).isActive = true
        valueLabel.topAnchor.constraint(equalTo: fieldLabel.bottomAnchor, constant: 4).isActive = true
        valueLabel.heightAnchor.constraint(equalToConstant: 16).isActive = true
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = .cbWhite
    }
}
