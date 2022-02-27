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
    
    var title: String {
        switch self {
        case .email: return "Email"
        case .name: return "Comprador"
        case .date: return "Criado em"
        case .status: return "Status"
        }
    }
    
    var imageIcon: UIImage? {
        switch self {
        case .name: return UIImage(named: "user")?.withTintColor(.defaultIconColor)
        case .email: return UIImage(named: "mail")?.withTintColor(.defaultIconColor)
        case .date: return UIImage(named: "calendar")?.withTintColor(.defaultBackground)
        case .status: return UIImage(named: "time")?.withTintColor(.defaultIconColor)
        }
    }
}

class TransactionDetailInfoView: UIView {
    
    private lazy var infoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = infoType.imageIcon
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var infoTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 12)
        label.text = infoType.title
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
            infoImage.widthAnchor.constraint(equalToConstant: 36),
            infoImage.heightAnchor.constraint(equalToConstant: 36),
            
            infoTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            infoTitleLabel.bottomAnchor.constraint(equalTo: infoValueLabel.topAnchor, constant: -8),
            
            infoValueLabel.leadingAnchor.constraint(equalTo: infoTitleLabel.leadingAnchor),
            infoValueLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }
}
