//
//  ExtractCell.swift
//  desafio-ios
//
//  Created by Amaryllis Baldrez on 18/03/22.
//

import Foundation
import UIKit

class ExtractCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureViews()
    }
        
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    lazy var valueLabel: UILabel = {
        let valueLabel = UILabel()
        valueLabel.text = "R$30,00"
        return valueLabel
    }()
    
    lazy var typeExtractLabel: UILabel = {
        let typeExtractLabel = UILabel()
        typeExtractLabel.text = "Transferencia recebida"
        return typeExtractLabel
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.text = "Lucas Costa"
        return nameLabel
    }()
    
    lazy var hourLabel: UILabel = {
        let hourLabel = UILabel()
        hourLabel.text = "17:35"
        return hourLabel
    }()
    
    lazy var icon: UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(named: "ic_arrow-down-in")
        return icon
    }()
    
    func configureViews() {
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        typeExtractLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        hourLabel.translatesAutoresizingMaskIntoConstraints = false
        icon.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(valueLabel)
        contentView.addSubview(typeExtractLabel)
        contentView.addSubview(nameLabel)
        contentView.addSubview(hourLabel)
        contentView.addSubview(icon)
        
        NSLayoutConstraint.activate([
            icon.leftAnchor.constraint(equalToSystemSpacingAfter: self.leftAnchor, multiplier: 2.10),
            icon.topAnchor.constraint(equalToSystemSpacingBelow: self.topAnchor, multiplier: 2.00),
            icon.heightAnchor.constraint(equalTo: valueLabel.heightAnchor),
            icon.widthAnchor.constraint(lessThanOrEqualToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            valueLabel.leftAnchor.constraint(equalToSystemSpacingAfter: icon.rightAnchor, multiplier: 1.90),
            valueLabel.topAnchor.constraint(equalTo: icon.topAnchor)
        ])
        
        NSLayoutConstraint.activate([
            typeExtractLabel.leftAnchor.constraint(equalTo: valueLabel.leftAnchor),
            typeExtractLabel.topAnchor.constraint(equalToSystemSpacingBelow: valueLabel.bottomAnchor, multiplier: 0.30)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.leftAnchor.constraint(equalTo: valueLabel.leftAnchor),
            nameLabel.topAnchor.constraint(equalToSystemSpacingBelow: typeExtractLabel.bottomAnchor, multiplier: 0.30)
        ])
        
        NSLayoutConstraint.activate([
            hourLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -9.00),
            hourLabel.topAnchor.constraint(equalToSystemSpacingBelow: typeExtractLabel.bottomAnchor, multiplier: 0.40)
        ])
        
        
    }
    
}
