//
//  TransactionDetailValueView.swift
//  DesafioCora
//
//  Created by user205543 on 2/27/22.
//

import Foundation
import UIKit

class TransactionDetailValueView: UIView {
    
    private lazy var infoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "credit-card")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var infoDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 12)
        label.text = paymentType.description
        return label
    }()
    
    private lazy var infoValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        setupViews()
        setupConstraints()
    }
    
    var valueText: String {
        get { infoValueLabel.text ?? "" }
        set { infoValueLabel.text = newValue }
    }
    
    var paymentType: PaymentType = .creditCard
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = .white
        addSubview(infoImage)
        addSubview(infoValueLabel)
        addSubview(infoDescriptionLabel)
    }
    
    private func setupConstraints() {
        addConstraints([
            infoImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            infoImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            infoImage.trailingAnchor.constraint(equalTo: infoValueLabel.leadingAnchor, constant: -16),
            infoImage.widthAnchor.constraint(equalToConstant: 36),
            infoImage.heightAnchor.constraint(equalToConstant: 36),
            
            infoValueLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            infoValueLabel.bottomAnchor.constraint(equalTo: infoDescriptionLabel.topAnchor, constant: -8),
            
            infoDescriptionLabel.leadingAnchor.constraint(equalTo: infoValueLabel.leadingAnchor),
            infoDescriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }
}
