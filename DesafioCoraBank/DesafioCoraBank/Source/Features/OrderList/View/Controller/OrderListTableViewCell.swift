//
//  OrderListTableViewCell.swift
//  DesafioCoraBank
//
//  Created by Roger Sanoli on 24/04/20.
//  Copyright © 2020 RogerSanoli. All rights reserved.
//

import Foundation
import UIKit

final class OrderListTableViewCell: UITableViewCell {
    
    public lazy var orderValueView = OrderValueView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    public func setup(_ viewModel: OrderValueViewModel, isFirst: Bool) {
        orderValueView.setup(viewModel)
        layer.cornerRadius = isFirst ? .cbCornerRadius : 0
        layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
}

extension OrderListTableViewCell: CodeView {
    func buildViewHierarchy() {
        contentView.addSubview(orderValueView)
    }
    
    func setupConstraints() {
        self.translatesAutoresizingMaskIntoConstraints = false

        orderValueView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0).isActive = true
        orderValueView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        orderValueView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0).isActive = true
        orderValueView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true
    }
    
    func setupAdditionalConfiguration() {
        self.selectionStyle = .none
        self.clipsToBounds = true
    }
}
