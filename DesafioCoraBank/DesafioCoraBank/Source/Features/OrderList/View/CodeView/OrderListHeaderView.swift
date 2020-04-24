//
//  OrderListHeaderView.swift
//  DesafioCoraBank
//
//  Created by Roger Sanoli on 24/04/20.
//  Copyright © 2020 RogerSanoli. All rights reserved.
//

import Foundation
import UIKit

final class OrderListHeaderView: UIView {
    
    private let viewModel: OrderListHeaderViewModel
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .cbWhite
        label.font = .cbBold(20)
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init(frame: CGRect = .zero, viewModel: OrderListHeaderViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
}

extension OrderListHeaderView: CodeView {
    func buildViewHierarchy() {
        addSubview(titleLabel)
        addSubview(subtitleLabel)
    }
    
    func setupConstraints() {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: .cbTopMargin).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: .cbLeftMargin).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: .cbRightMargin).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 18).isActive = true

        subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: .cbLineBreakMargin).isActive = true
        subtitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: .cbLeftMargin).isActive = true
        subtitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: .cbRightMargin).isActive = true
        subtitleLabel.heightAnchor.constraint(equalToConstant: 14).isActive = true
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = .cbDarkBlue
        titleLabel.text = "order_header_title".localized
        subtitleLabel.attributedText = self.viewModel.subtitle
    }
}
