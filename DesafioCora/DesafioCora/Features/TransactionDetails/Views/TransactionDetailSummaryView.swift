//
//  TransactionDetailSummaryView.swift
//  DesafioCora
//
//  Created by user205543 on 2/27/22.
//

import Foundation
import UIKit

class TransactionDetailSummaryView: UIView {
    
    private lazy var summaryTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Resumo financeiro"
        label.textColor = .darkGray
        label.font = .boldSystemFont(ofSize: 14)
        return label
    }()
    
    private lazy var totalTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Valor Totoal"
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    
    private lazy var totalValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    
    private lazy var taxTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Taxas"
        label.textColor = .red
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    
    private lazy var taxValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .red
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    
    private lazy var receivedTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Meu recebimento"
        label.textColor = .blue
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    private lazy var receivedValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .blue
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(viewModel: SummaryDetailsViewModel) {
        totalValueLabel.text = viewModel.totalValueText
        taxValueLabel.text = viewModel.taxValueText
        receivedValueLabel.text = viewModel.receivedValueText
    }
  
    private func setupViews() {
        backgroundColor = .lightBackground
        addSubview(summaryTitleLabel)
        addSubview(totalTitleLabel)
        addSubview(totalValueLabel)
        addSubview(taxTitleLabel)
        addSubview(taxValueLabel)
        addSubview(receivedTitleLabel)
        addSubview(receivedValueLabel)
    }
    
    private func setupConstraints() {
        addConstraints([
            summaryTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            summaryTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            summaryTitleLabel.bottomAnchor.constraint(equalTo: totalTitleLabel.topAnchor, constant: -32),
            
            totalTitleLabel.leadingAnchor.constraint(equalTo: summaryTitleLabel.leadingAnchor),
            totalTitleLabel.bottomAnchor.constraint(equalTo: taxTitleLabel.topAnchor, constant: -8),
            
            taxTitleLabel.leadingAnchor.constraint(equalTo: summaryTitleLabel.leadingAnchor),
            taxTitleLabel.bottomAnchor.constraint(equalTo: receivedTitleLabel.topAnchor, constant: -24),
            
            receivedTitleLabel.leadingAnchor.constraint(equalTo: summaryTitleLabel.leadingAnchor),
            receivedTitleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -24),
            
            totalValueLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            totalValueLabel.centerYAnchor.constraint(equalTo: totalTitleLabel.centerYAnchor),
            
            taxValueLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            taxValueLabel.centerYAnchor.constraint(equalTo: taxTitleLabel.centerYAnchor),
            
            receivedValueLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            receivedValueLabel.centerYAnchor.constraint(equalTo: receivedTitleLabel.centerYAnchor),
            
        ])
    }
}
