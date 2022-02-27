//
//  TransactionIdView.swift
//  DesafioCora
//
//  Created by user205543 on 2/27/22.
//

import Foundation
import UIKit

class TransactionIDView: UIView {
    private lazy var idLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 14)
        label.textColor = .darkGray
        label.numberOfLines = 0
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var transactionId: String? {
        get { idLabel.text }
        set { idLabel.text = newValue }
    }
    
    private func setupViews() {
        backgroundColor = .white
        addSubview(idLabel)
    }
    
    private func setupConstraints() {
        addConstraints([
            idLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            idLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            idLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            idLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }
}
