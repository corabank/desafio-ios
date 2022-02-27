//
//  TransactionDetailsViewController.swift
//  DesafioCora
//
//  Created by user205543 on 2/27/22.
//

import Foundation
import UIKit

protocol TransactionDetailsDisplaying: AnyObject {
    func displayTransaction(_ transaction: TransactionModel)
}

final class TransactionDetailsVewController: UIViewController {
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.backgroundColor = .white
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 8
        stackView.backgroundColor = .white
        return stackView
    }()
    
    private lazy var valueInfoView: TransactionDetailValueView = {
        let dtView = TransactionDetailValueView()
        dtView.translatesAutoresizingMaskIntoConstraints = false
        return dtView
    }()
    
    private lazy var nameInfoView: TransactionDetailInfoView = {
        let dtView = TransactionDetailInfoView(infoType: .name)
        dtView.translatesAutoresizingMaskIntoConstraints = false
        return dtView
    }()
    
    private lazy var emailInfoView: TransactionDetailInfoView = {
        let dtView = TransactionDetailInfoView(infoType: .email)
        dtView.translatesAutoresizingMaskIntoConstraints = false
        return dtView
    }()
    
    private lazy var dateInfoView: TransactionDetailInfoView = {
        let dtView = TransactionDetailInfoView(infoType: .date)
        dtView.translatesAutoresizingMaskIntoConstraints = false
        return dtView
    }()
    
    private lazy var statusInfoView: TransactionDetailInfoView = {
        let dtView = TransactionDetailInfoView(infoType: .status)
        dtView.translatesAutoresizingMaskIntoConstraints = false
        return dtView
    }()
    
    private lazy var summaryView: TransactionDetailSummaryView = {
        let summaryView = TransactionDetailSummaryView()
        summaryView.translatesAutoresizingMaskIntoConstraints = false
        return summaryView
    }()
    
    private lazy var transactionIdView: TransactionIDView = {
        let idView = TransactionIDView()
        idView.translatesAutoresizingMaskIntoConstraints = false
        return idView
    }()
    
    let interactor: TransactionDetailsInteracting
    
    init(interactor: TransactionDetailsInteracting) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.loadTransaction()
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        setupNavigationBar()
        scrollView.addSubview(contentView)
        view.addSubview(scrollView)
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(valueInfoView)
        stackView.addArrangedSubview(nameInfoView)
        stackView.addArrangedSubview(emailInfoView)
        stackView.addArrangedSubview(dateInfoView)
        stackView.addArrangedSubview(statusInfoView)
        stackView.addArrangedSubview(summaryView)
        stackView.addArrangedSubview(transactionIdView)
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.backgroundColor = .lightBackground
        let barItem = UIBarButtonItem(title: "Voltar", style: .plain, target: self, action: #selector(closeAction))
        barItem.tintColor = .red
        navigationItem.leftBarButtonItem = barItem
    }
    
    private func setupConstraints() {
        view.addConstraints([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: view.widthAnchor),
            
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
    
    @objc
    private func closeAction() {
        dismiss(animated: true)
    }
}

extension TransactionDetailsVewController: TransactionDetailsDisplaying {
    func displayTransaction(_ transaction: TransactionModel) {
        valueInfoView.valueText = transaction.value.currency
        nameInfoView.valueText = transaction.userName
        emailInfoView.valueText = transaction.userEmail
        dateInfoView.valueText = transaction.transactionDate.formattedString()
        statusInfoView.valueText = transaction.paymentStatus.description
        
        summaryView.configure(viewModel: .init(totalValue: transaction.value, tax: transaction.tax))
        transactionIdView.transactionId = transaction.id
    }
}
