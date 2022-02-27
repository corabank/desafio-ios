//
//  TransactionCell.swift
//  DesafioCora
//
//  Created by user205543 on 2/27/22.
//

import Foundation
import UIKit

class TransactionCell: UITableViewCell {
    private lazy var transactionImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "credit-card")?.withTintColor(.defaultIconColor)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    
    private lazy var userLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    private lazy var timeStampLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    private lazy var paymentStatusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(transactionImageView)
        addSubview(valueLabel)
        addSubview(userLabel)
        addSubview(timeStampLabel)
        addSubview(paymentStatusLabel)
    }
    
    private func setupConstraints() {
        addConstraints([
            transactionImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            transactionImageView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            transactionImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            transactionImageView.trailingAnchor.constraint(equalTo: valueLabel.leadingAnchor, constant: -16),
            transactionImageView.widthAnchor.constraint(equalToConstant: 48),
            transactionImageView.heightAnchor.constraint(equalToConstant: 48),
            
            valueLabel.topAnchor.constraint(equalTo: transactionImageView.topAnchor),
            
            userLabel.leadingAnchor.constraint(equalTo: valueLabel.leadingAnchor),
            userLabel.topAnchor.constraint(equalTo: valueLabel.bottomAnchor, constant: 4),
            userLabel.bottomAnchor.constraint(equalTo: transactionImageView.bottomAnchor),
            
            paymentStatusLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            paymentStatusLabel.centerYAnchor.constraint(equalTo: valueLabel.centerYAnchor),
            
            timeStampLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            timeStampLabel.topAnchor.constraint(equalTo: paymentStatusLabel.bottomAnchor),
            timeStampLabel.centerYAnchor.constraint(equalTo: userLabel.centerYAnchor)
        ])
    }
    
    func configureCell(data: TransactionModel) {
        self.userLabel.text = data.userEmail
        self.valueLabel.text = data.value.currency
        self.timeStampLabel.text = data.transactionDate.formattedString()
        self.paymentStatusLabel.text = data.paymentStatus.description
        self.paymentStatusLabel.textColor = data.paymentStatus.color
    }
}
