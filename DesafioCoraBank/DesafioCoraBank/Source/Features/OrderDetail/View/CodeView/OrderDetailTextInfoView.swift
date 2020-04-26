//
//  OrderDetailTextInfoView.swift
//  DesafioCoraBank
//
//  Created by Roger Sanoli on 24/04/20.
//  Copyright © 2020 RogerSanoli. All rights reserved.
//

import Foundation
import UIKit

final class OrderDetailTextInfoView: UIView {
    
    private lazy var fieldLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var currencyLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    private lazy var valueLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        return label
    }()
    
    private var fontSize: CGFloat?
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    public func setup(_ viewModel: OrderDetailTextInfoViewModel) {
        fieldLabel.text = viewModel.fieldText
        fieldLabel.font = viewModel.fontSize > 15 ? .cbBold(viewModel.fontSize) : .cbRegular(viewModel.fontSize)
        fieldLabel.textColor = viewModel.fontColor
        
        currencyLabel.text = viewModel.currency
        currencyLabel.font = viewModel.fontSize > 15 ? .cbBold(viewModel.fontSize) : .cbRegular(viewModel.fontSize)
        currencyLabel.textColor = viewModel.fontColor
        
        valueLabel.text = viewModel.valueText
        valueLabel.font = viewModel.fontSize > 15 ? .cbBold(viewModel.fontSize) : .cbRegular(viewModel.fontSize)
        valueLabel.textColor = viewModel.fontColor
        
        fontSize = viewModel.fontSize
    }
}

extension OrderDetailTextInfoView: CodeView {
    func buildViewHierarchy() {
        self.addSubview(fieldLabel)
        self.addSubview(currencyLabel)
        self.addSubview(valueLabel)
    }
    
    func setupConstraints() {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        valueLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: .cbRightMargin).isActive = true
        valueLabel.widthAnchor.constraint(equalToConstant: 80).isActive = true
        valueLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        valueLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        currencyLabel.trailingAnchor.constraint(equalTo: valueLabel.leadingAnchor, constant: .cbWordSpaceMargin).isActive = true
        currencyLabel.widthAnchor.constraint(equalToConstant: 24).isActive = true
        currencyLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        currencyLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        fieldLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: .cbLeftMargin).isActive = true
        fieldLabel.trailingAnchor.constraint(equalTo: currencyLabel.leadingAnchor, constant: .cbWordSpaceMargin).isActive = true
        fieldLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        fieldLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = .cbLightGray
    }
}
