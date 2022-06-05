//
//  ReceiptDetailCell.swift
//  DesafioiOS
//
//  Created by Allana Castenharo Santamaria on 31/05/22.
//

import UIKit

final class ReceiptDetailCell: UITableViewCell {
    
    static let identifier = String(describing: ReceiptDetailCell.self)
    var model: Model?

    private lazy var detailStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, nameLabel,cpfLabel, bankLabel, account])
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.spacing = .coraSpacing(.base01)
        return stackView
    }()
    
    private var titleLabel: CoraLabel = {
        let label = CoraLabel(fontSize: .body2, fontWeight: .regular, color: .offBlack)
        label.numberOfLines = .zero
        return label
    }()
    
    private var nameLabel: CoraLabel = {
        let label = CoraLabel(fontSize: .body1, fontWeight: .bold, color: .offBlack)
        label.numberOfLines = .zero
        return label
    }()
    
    private var cpfLabel: CoraLabel = {
        let label = CoraLabel(fontSize: .body2, fontWeight: .regular, color: .gray1)
        label.numberOfLines = .zero
        return label
    }()
    
    private var bankLabel: CoraLabel = {
        let label = CoraLabel(fontSize: .body2, fontWeight: .regular, color: .gray1)
        label.numberOfLines = .zero
        return label
    }()
    
    private var account: CoraLabel = {
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
    
    func setup(model: Model) {
        titleLabel.text =  model.title
        nameLabel.text = model.name
        cpfLabel.text = model.cpf
        bankLabel.text = model.bank
        account.text = model.account
        self.model = model
    }
}

extension ReceiptDetailCell: ViewCode {
    
    func buildViewHierarchy() {
        addSubview(detailStackView)
    }
    
    func setupConstraints() {
        detailStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([            
            detailStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .coraSpacing(.base07)),
            detailStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -.coraSpacing(.base07)),
            detailStackView.topAnchor.constraint(equalTo: topAnchor, constant: .coraSpacing(.base07)),
            detailStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func setupAdditionalConfiguration() {
        selectionStyle = .none
    }
}

extension ReceiptDetailCell {
    struct Model {
        let title: String?
        let name: String?
        let cpf: String?
        let bank: String?
        let account: String?
    }
}
