//
//  HeaderView.swift
//  Desafio Cora
//
//  Created by João Pedro DTI on 17/05/22.
//

import UIKit

protocol HeaderViewDelegate: AnyObject {
    func payButtonPressed()
    func automaticDebitPRessed()
    func barChartPressed()
}

class HeaderView: UIView {
    weak var delegate: HeaderViewDelegate?

    private lazy var chart: BarChartView = {
        let chart = BarChartView()
        chart.delegate = self
        chart.translatesAutoresizingMaskIntoConstraints = false
        return chart
    }()

    private lazy var totalValueLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.getFont(.bold(size: 22))()
        label.textColor = .secondaryLight
        return label
    }()

    private lazy var labelDescription: UILabel = {
        let label = UILabel()
        label.font = Fonts.getFont(.regular(size: 14))()
        label.textColor = .white
        return label
    }()

    private lazy var labelDescription1: UILabel = {
        let label = UILabel()
        label.font = Fonts.getFont(.regular(size: 14))()
        label.textColor = .white
        return label
    }()

    private lazy var labelDescription2: UILabel = {
        let label = UILabel()
        label.font = Fonts.getFont(.regular(size: 14))()
        label.textColor = .white
        return label
    }()

    private lazy var payInvoiceButton: UIButton = {
        let button = UIButton()
        button.setTitle(Strings.payInvoiceButtonTitle, for: [])
        button.titleLabel?.font = Fonts.getFont(.regular(size: 14))()
        button.backgroundColor = .primary
        button.layer.cornerRadius = 8
        button.layer.borderColor = UIColor.primary.cgColor
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(payInvoiceTapped), for: .touchUpInside)
        button.contentHuggingPriority(for: .horizontal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var autoDebitButton: UIButton = {
        let button = UIButton()
        button.setTitle(Strings.automaticDebitButtonTitle, for: [])
        button.setTitleColor(.white, for: [])
        button.addImageOnRightSide(Images.rightArrowPink)
        button.backgroundColor = .offBlack
        button.addTarget(self, action: #selector(autoDebitTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var labelStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [totalValueLabel, labelDescription, labelDescription1, labelDescription2])
        stackView.spacing = 4
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var infoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [labelStackView, payInvoiceButton])
        stackView.spacing = 0
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc
    func payInvoiceTapped() {
        delegate?.payButtonPressed()
    }

    @objc
    func autoDebitTapped() {
        delegate?.automaticDebitPRessed()
    }

    func barChartPressed() {
        delegate?.barChartPressed()
    }

    func configure(data: InvoiceResume?) {
        guard let data = data else {
            return
        }
        totalValueLabel.text = "R$ \(data.infos.totalValue.description)"
        labelDescription1.text = data.infos.totalValue.description
        labelDescription2.text = Strings.expirationData(data.infos.expirationDate)
        chart.setData(data.chart)
    }
}

extension HeaderView: CodeView {
    func buildViewHierarchy() {
        addSubview(chart)
        addSubview(infoStackView)
        addSubview(autoDebitButton)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            chart.topAnchor.constraint(equalTo: self.topAnchor, constant: 12),
            chart.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            chart.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            chart.heightAnchor.constraint(equalToConstant: 128)
        ])

        NSLayoutConstraint.activate([
            infoStackView.topAnchor.constraint(equalTo: chart.bottomAnchor, constant: 12),
            infoStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            infoStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24)
        ])

        NSLayoutConstraint.activate([
            autoDebitButton.topAnchor.constraint(equalTo: infoStackView.bottomAnchor, constant: 16),
            autoDebitButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            autoDebitButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            autoDebitButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
            autoDebitButton.heightAnchor.constraint(equalToConstant: 48)
        ])

        NSLayoutConstraint.activate([
            payInvoiceButton.widthAnchor.constraint(equalTo: infoStackView.widthAnchor, multiplier: 0.3),
            payInvoiceButton.heightAnchor.constraint(equalTo: infoStackView.heightAnchor, multiplier: 0.4)
        ])
    }

    func setupAdditionalConfigaration() {
        backgroundColor = .black
    }
}

extension HeaderView: BarChartViewDelegate {
    func barClicked(barIndex: Int) {
        // Callback to call the reloadTableView or send to ViewController to make a new request pelo delegate
    }
}
