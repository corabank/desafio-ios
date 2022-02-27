//
//  TransactionDetailInfoView.swift
//  DesafioCora
//
//  Created by user205543 on 2/27/22.
//

import Foundation
import UIKit

enum InfoType {
    case name
    case email
    case date
    case status
}

class TransactionDetailInfoView: UIView {
    
    private lazy var infoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "credit-card")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var infoTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    private lazy var infoValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    
    let infoType: InfoType
    
    init(infoType: InfoType) {
        self.infoType = infoType
        super.init(frame: .zero)
        setupViews()
        setupConstraints()
    }
    
    var valueText: String {
        get { infoValueLabel.text ?? "" }
        set { infoValueLabel.text = newValue }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = .white
        addSubview(infoImage)
        addSubview(infoTitleLabel)
        addSubview(infoValueLabel)
    }
    
    private func setupConstraints() {
        addConstraints([
            infoImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            infoImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            infoImage.trailingAnchor.constraint(equalTo: infoTitleLabel.leadingAnchor, constant: -16),
            
            infoTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            infoTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            infoTitleLabel.bottomAnchor.constraint(equalTo: infoValueLabel.topAnchor, constant: -8),
            
            infoValueLabel.leadingAnchor.constraint(equalTo: infoTitleLabel.leadingAnchor),
            infoValueLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            infoValueLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }
}
