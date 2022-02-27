//
//  TransactionsListHeaderView.swift
//  DesafioCora
//
//  Created by user205543 on 2/27/22.
//

import Foundation
import UIKit

class TransactionsListHeaderView: UIView {
    private lazy var requestsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Pedidos"
        label.font = .boldSystemFont(ofSize: 24)
        return label
    }()
    
    private lazy var requestsDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "320 pedidos, totalizando R$ 115.345,45"
        return label
    }()
    
    private lazy var usernameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Lucas"
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .lightGray
        addSubview(requestsLabel)
        addSubview(requestsDescriptionLabel)
        addSubview(usernameLabel)
        
        addConstraints([
            requestsLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            requestsLabel.topAnchor.constraint(equalTo: topAnchor, constant: 32),
            
            requestsDescriptionLabel.topAnchor.constraint(equalTo: requestsLabel.bottomAnchor, constant: 8),
            requestsDescriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            requestsDescriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            
            usernameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            usernameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8)
        ])
    }
}
