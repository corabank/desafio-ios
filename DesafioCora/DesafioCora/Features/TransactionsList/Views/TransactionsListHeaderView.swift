//
//  TransactionsListHeaderView.swift
//  DesafioCora
//
//  Created by user205543 on 2/27/22.
//

import Foundation
import UIKit

class TransactionsListHeaderView: UIView {
    private lazy var headerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "logo")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var requestsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Pedidos"
        label.font = .boldSystemFont(ofSize: 24)
        label.textColor = .white
        return label
    }()
    
    private lazy var requestsDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "320 pedidos, totalizando R$ 115.345,45"
        label.textColor = .lightGray
        return label
    }()
    
    private lazy var usernameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Olá, Lucas"
        label.textColor = .lightGray
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
        backgroundColor = .defaultBackground
        addSubview(headerImageView)
        addSubview(requestsLabel)
        addSubview(requestsDescriptionLabel)
        addSubview(usernameLabel)
        
        addConstraints([
            headerImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            headerImageView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            headerImageView.widthAnchor.constraint(equalToConstant: 48),
            headerImageView.heightAnchor.constraint(equalToConstant: 48),
            
            requestsLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            requestsLabel.topAnchor.constraint(equalTo: headerImageView.bottomAnchor, constant: 24),
            
            requestsDescriptionLabel.topAnchor.constraint(equalTo: requestsLabel.bottomAnchor, constant: 8),
            requestsDescriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            requestsDescriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            
            usernameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            usernameLabel.centerYAnchor.constraint(equalTo: headerImageView.centerYAnchor)
        ])
    }
}
