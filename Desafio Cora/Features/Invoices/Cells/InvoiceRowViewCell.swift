//
//  InvoiceRowViewCell.swift
//  Desafio Cora
//
//  Created by João Pedro DTI on 15/05/22.
//

import UIKit

public final class InvoiceRowViewCell: UITableViewCell {
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.getFont(.regular(size: 12))()
        label.textColor = .offBlack
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.getFont(.regular(size: 12))()
        label.textColor = .offBlack
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var obsDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.getFont(.regular(size: 12))()
        label.textColor = .gray1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var obsValueLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.getFont(.bold(size: 12))()
        label.textColor = .gray1
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.getFont(.bold(size: 12))()
        label.textColor = .offBlack
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var transactionStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [dateLabel, descriptionLabel, valueLabel])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var emptyView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var obsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [emptyView, obsDescriptionLabel, obsValueLabel])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var cellStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [transactionStackView, obsStackView])
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func passData(model: Transaction) {
        dateLabel.text = model.date
        descriptionLabel.text = model.transactionDescription
        valueLabel.text = model.value.description
        obsDescriptionLabel.text = model.observationDescription
        obsValueLabel.text = model.observationValue?.description

        dateLabel.textColor = model.textColor()
        descriptionLabel.textColor = model.textColor()
        valueLabel.textColor = model.textColor()

        if (model.observationDescription?.isEmpty) == nil {
            obsStackView.isHidden = true
        } else {
            obsStackView.isHidden = false
        }
    }
}

extension InvoiceRowViewCell: CodeView {
    func buildViewHierarchy() {
        addSubview(cellStackView)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            cellStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            cellStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            cellStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            cellStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0)
        ])
    }

    func setupAdditionalConfigaration() {
        contentView.backgroundColor = .clear
    }
}
