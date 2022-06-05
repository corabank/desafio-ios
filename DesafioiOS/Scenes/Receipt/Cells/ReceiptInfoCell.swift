//
//  ReceiptInfoCell.swift
//  DesafioiOS
//
//  Created by Allana Castenharo Santamaria on 31/05/22.
//

import UIKit

final class ReceiptInfoCell: UITableViewCell {
    typealias Strings = Localization.ReceiptInfoCell
    static let identifier = String(describing: ReceiptInfoCell.self)
    
    private lazy var valueStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [valueTitleLabel, valueLabel])
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.spacing = .coraSpacing(.base01)
        return stackView
    }()
    
    private lazy var dateStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [dateTitleLabel, dateLabel])
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.spacing = .coraSpacing(.base01)
        return stackView
    }()
    
    private var valueTitleLabel: CoraLabel = {
        let label = CoraLabel(fontSize: .body2, fontWeight: .regular, color: .offBlack)
        label.numberOfLines = .zero
        label.text = Strings.valueTitle
        return label
    }()
    
    private var valueLabel: CoraLabel = {
        let label = CoraLabel(fontSize: .body1, fontWeight: .bold, color: .offBlack)
        label.numberOfLines = .zero
        return label
    }()
    
    private var dateTitleLabel: CoraLabel = {
        let label = CoraLabel(fontSize: .body2, fontWeight: .regular, color: .offBlack)
        label.numberOfLines = .zero
        label.text = Strings.dateTitle
        return label
    }()
    
    private var dateLabel: CoraLabel = {
        let label = CoraLabel(fontSize: .body1, fontWeight: .bold, color: .offBlack)
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
    
    func setup(value: String?, date: String?) {
        valueLabel.text = value
        dateLabel.text = date
    }
}

extension ReceiptInfoCell: ViewCode {
    
    func buildViewHierarchy() {
        addSubview(valueStackView)
        addSubview(dateStackView)
    }
    
    func setupConstraints() {
        valueStackView.translatesAutoresizingMaskIntoConstraints = false
        dateStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            /// ValueStackView
            valueStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .coraSpacing(.base07)),
            valueStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -.coraSpacing(.base07)),
            valueStackView.topAnchor.constraint(equalTo: topAnchor, constant: .coraSpacing(.base07)),
            
            /// DateStackView
            dateStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .coraSpacing(.base07)),
            dateStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -.coraSpacing(.base07)),
            dateStackView.topAnchor.constraint(equalTo: valueStackView.bottomAnchor, constant: .coraSpacing(.base07)),
            dateStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func setupAdditionalConfiguration() {
        selectionStyle = .none
    }
}
