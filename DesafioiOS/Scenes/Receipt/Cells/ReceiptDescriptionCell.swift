//
//  ReceiptDescriptionCell.swift
//  DesafioiOS
//
//  Created by Allana Castenharo Santamaria on 31/05/22.
//

import UIKit

final class ReceiptDescriptionCell: UITableViewCell {
    typealias Strings = Localization.ReceiptDescriptionCell

    static let identifier = String(describing: ReceiptDescriptionCell.self)

    private var titleLabel: CoraLabel = {
        let label = CoraLabel(fontSize: .body2, fontWeight: .regular, color: .offBlack)
        label.text = Strings.title
        label.numberOfLines = .zero
        return label
    }()
    
    private var descriptionLabel: CoraLabel = {
        let label = CoraLabel(fontSize: .body2, fontWeight: .regular, color: .gray1)
        label.numberOfLines = .zero
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        nil
    }
    
    func setup(description: String?) {
        descriptionLabel.text = description
    }
}

extension ReceiptDescriptionCell: ViewCode {
    
    func buildViewHierarchy() {
        addSubview(titleLabel)
        addSubview(descriptionLabel)
    }
    
    func setupConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            /// Title description
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .coraSpacing(.base07)),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -.coraSpacing(.base07)),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: .coraSpacing(.base07)),
            
            /// Description
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .coraSpacing(.base07)),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -.coraSpacing(.base07)),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: .coraSpacing(.base01) ),
            descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func setupAdditionalConfiguration() {
        selectionStyle = .none
    }
}
