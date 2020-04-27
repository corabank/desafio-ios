//
//  OrderValueView.swift
//  DesafioCoraBank
//
//  Created by Roger Sanoli on 24/04/20.
//  Copyright © 2020 RogerSanoli. All rights reserved.
//

import Foundation
import UIKit

final class OrderValueView: UIView {
    
    private lazy var iconImage: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "icon-card")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    public lazy var valueLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .cbBlack
        label.font = .cbBold(16)
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .cbDarkGray
        label.font = .cbLight(10)
        return label
    }()
    
    private lazy var statusLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .cbGreen
        label.font = .cbRegular(14)
        label.textAlignment = .right
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .cbDarkGray
        label.font = .cbLight(10)
        label.textAlignment = .right
        return label
    }()
    
    override init(frame: CGRect = .zero) {
        super.init(frame:frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    public func setup(_ viewModel: OrderValueViewModel) {
        valueLabel.text = viewModel.value
        valueLabel.accessibilityValue = viewModel.value
        subtitleLabel.text = viewModel.subtitle
        subtitleLabel.accessibilityValue = viewModel.subtitle
        statusLabel.text = viewModel.status
        statusLabel.textColor = viewModel.statusColor
        statusLabel.accessibilityValue = viewModel.status
        dateLabel.text = viewModel.friendlyDate
        dateLabel.accessibilityValue = viewModel.friendlyDate
    }
}

extension OrderValueView: CodeView {
    func buildViewHierarchy() {
        self.addSubview(iconImage)
        self.addSubview(statusLabel)
        self.addSubview(dateLabel)
        self.addSubview(valueLabel)
        self.addSubview(subtitleLabel)
    }
    
    func setupConstraints() {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        let topLabelsHeight: CGFloat = 16
        let bottomLabelsHeight: CGFloat = 14
        let rightLabelsWidth: CGFloat = 80
        let customLineBreak: CGFloat = 4
        
        iconImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: .cbLeftMargin).isActive = true
        iconImage.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        iconImage.heightAnchor.constraint(equalToConstant: 40).isActive = true
        iconImage.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        statusLabel.topAnchor.constraint(equalTo: iconImage.topAnchor, constant: 3).isActive = true
        statusLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: .cbRightMargin).isActive = true
        statusLabel.heightAnchor.constraint(equalToConstant: topLabelsHeight).isActive = true
        statusLabel.widthAnchor.constraint(equalToConstant: rightLabelsWidth).isActive = true
        
        dateLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: .cbRightMargin).isActive = true
        dateLabel.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: customLineBreak).isActive = true
        dateLabel.heightAnchor.constraint(equalToConstant: bottomLabelsHeight).isActive = true
        dateLabel.widthAnchor.constraint(equalToConstant: rightLabelsWidth).isActive = true
        
        valueLabel.leadingAnchor.constraint(equalTo: iconImage.trailingAnchor, constant: .cbLeftMargin).isActive = true
        valueLabel.trailingAnchor.constraint(equalTo: statusLabel.leadingAnchor, constant: .cbWordSpaceMargin).isActive = true
        valueLabel.topAnchor.constraint(equalTo: iconImage.topAnchor, constant: 3).isActive = true
        valueLabel.heightAnchor.constraint(equalToConstant: topLabelsHeight).isActive = true
        
        subtitleLabel.leadingAnchor.constraint(equalTo: iconImage.trailingAnchor, constant: .cbLeftMargin).isActive = true
        subtitleLabel.trailingAnchor.constraint(equalTo: dateLabel.leadingAnchor, constant: .cbWordSpaceMargin).isActive = true
        subtitleLabel.topAnchor.constraint(equalTo: valueLabel.bottomAnchor, constant: customLineBreak).isActive = true
        subtitleLabel.heightAnchor.constraint(equalToConstant: bottomLabelsHeight).isActive = true
    }
    
    func setupAdditionalConfiguration() {
        
        self.accessibilityLabel = "Value Cell"
        
        backgroundColor = .cbWhite
        valueLabel.isAccessibilityElement = true
        valueLabel.accessibilityLabel = "order_value".localized
        valueLabel.accessibilityTraits = .staticText
        
        subtitleLabel.isAccessibilityElement = true
        subtitleLabel.accessibilityLabel = "order_subtitle".localized
        subtitleLabel.accessibilityTraits = .staticText
        
        dateLabel.isAccessibilityElement = true
        dateLabel.accessibilityLabel = "order_created_at".localized
        dateLabel.accessibilityTraits = .staticText
        
        statusLabel.isAccessibilityElement = true
        statusLabel.accessibilityLabel = "order_status".localized
        statusLabel.accessibilityTraits = .staticText
    }
}
