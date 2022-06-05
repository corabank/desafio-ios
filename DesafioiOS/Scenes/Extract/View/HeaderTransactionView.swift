//
//  HeaderTransactionView.swift
//  DesafioiOS
//
//  Created by Allana Castenharo Santamaria on 29/05/22.
//

import UIKit

final class HeaderTransactionView: UIView {
    var containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    var dateTransactionLabel: CoraLabel = {
        let label = CoraLabel(fontSize: .caption, fontWeight: .regular, color: CoraColor.gray1)
        label.numberOfLines = .zero
        return label
    }()
    
    var totalValueTransactionLabel: CoraLabel = {
        let label = CoraLabel(fontSize: .caption, fontWeight: .regular, color: CoraColor.gray1)
        label.numberOfLines = .zero
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        nil
    }
    
    func setup(model: Model) {
        dateTransactionLabel.text = model.day
        totalValueTransactionLabel.text = model.balance
    }
}

extension HeaderTransactionView: ViewCode {
    func buildViewHierarchy() {
        addSubview(containerView)
        containerView.addSubview(dateTransactionLabel)
        containerView.addSubview(totalValueTransactionLabel)
    }
    
    func setupConstraints() {
        dateTransactionLabel.translatesAutoresizingMaskIntoConstraints = false
        totalValueTransactionLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            /// DateTransaction
            dateTransactionLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: .coraSpacing(.base02)),
            dateTransactionLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: .coraSpacing(.base07)),
            dateTransactionLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -.coraSpacing(.base02)),
            
            /// TotalValueTransaction
            totalValueTransactionLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: .coraSpacing(.base02)),
            totalValueTransactionLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -.coraSpacing(.base07)),
            totalValueTransactionLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -.coraSpacing(.base02)),
            
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = .coraColor(.gray4)
    }
}

extension HeaderTransactionView {
    struct Model {
        let day: String?
        let balance: String?
    }
}
