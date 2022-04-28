//
//  DetailStamentViewController.swift
//  CoraChallenge
//
//  Created by Fellipe Ricciardi Chiarello on 4/26/22.
//

import UIKit

class DetailStamentViewController: BaseViewController {
    
    lazy var mainScroll: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    lazy var mainStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleStack, transferDataStack ,descriptionStack, buttonStack])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 24
        return stackView
    }()
    
    lazy var titleStack: UIStackView = {
       let stackView = UIStackView(arrangedSubviews: [titleIcon, titleLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 24
        return stackView
    }()
    
    lazy var titleIcon: UIImageView = {
        let image = UIImage(named: "clock")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 24).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 24).isActive = true
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Avenir-Heavy", size: 16)
        label.textColor = .coraBlack
        return label
    }()
    
    lazy var transferDataStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [valueLabel, dateLabel, fromLabel, toLabel])
         stackView.translatesAutoresizingMaskIntoConstraints = false
         stackView.axis = .vertical
        stackView.spacing = 24
         return stackView
    }()
    
    lazy var valueLabel: StatementDetailLabelsView = {
        let view = StatementDetailLabelsView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.firstLabel.text = "Valor"
        view.labelType = .partial
        return view
    }()
    
    lazy var dateLabel: StatementDetailLabelsView = {
        let view = StatementDetailLabelsView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.firstLabel.text = "Data da transferência"
        view.labelType = .partial
        return view
    }()
    
    lazy var fromLabel: StatementDetailLabelsView = {
        let view = StatementDetailLabelsView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.firstLabel.text = "De"
        view.labelType = .full
        return view
    }()
    
    lazy var toLabel: StatementDetailLabelsView = {
        let view = StatementDetailLabelsView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.firstLabel.text = "Para"
        view.labelType = .full
        return view
    }()
    
    lazy var descriptionStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [descriptionLabel, descriptionMessage])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Avenir-Roman", size: 14)
        label.textColor = .coraDarkGray
        label.text = "Descrição"
        return label
    }()
    
    lazy var descriptionMessage: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Avenir-Roman", size: 14)
        label.textColor = .coraDarkGray
        label.numberOfLines = 0
        label.text = "Developed by the Intel Corporation, HDCP stands for high-bandwidth digital content protection. As the descriptive name implies."
        return label
    }()
    
    lazy var buttonStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [shareButton, linkButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        return stackView
    }()
    
    lazy var shareButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .coraPink
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.heightAnchor.constraint(equalToConstant: 48).isActive = true
        button.layer.cornerRadius = 16
        button.setTitle("Compartilhar comprovante", for: .normal)
        return button
    }()
    
    lazy var linkButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Cancelar agendamento", for: .normal)
        button.setTitleColor(UIColor.coraPink, for: .normal)
        button.titleLabel?.font = UIFont(name:"Avenir-Roman", size: 14)
        button.heightAnchor.constraint(equalToConstant: 36).isActive = true
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewCodeSetup()
        title = "Detalhes do agendamento"
    }
}

extension DetailStamentViewController: ViewCodeProtocol {
    func viewCodeHierarchySetup() {
        view.addSubview(mainScroll)
        mainScroll.addSubview(mainStack)
    }
    
    func viewCodeConstraintSetup() {
        NSLayoutConstraint.activate([
            mainScroll.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainScroll.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            mainScroll.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            mainScroll.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            mainStack.topAnchor.constraint(equalTo: mainScroll.topAnchor,constant: 24),
            mainStack.leadingAnchor.constraint(equalTo: mainScroll.leadingAnchor, constant: 24),
            mainStack.trailingAnchor.constraint(equalTo: mainScroll.trailingAnchor, constant: -24),
            mainStack.bottomAnchor.constraint(equalTo: mainScroll.bottomAnchor),
            mainStack.centerXAnchor.constraint(equalTo: mainScroll.centerXAnchor)
        ])
    }
    
    func viewCodeAditionalSetup() {
        view.backgroundColor = .white
    }
}

extension DetailStamentViewController: StatementViewControllerDelegate {
    func setupDetailStatementView(model: StatementModelData, date: String) {
        guard let sender = model.sender else { return }
        guard let receiver = model.receiver else { return }
        
        titleLabel.text = model.transactionType
        valueLabel.messageLabel.text = model.value?.doubleToCurrency() ?? String()
        dateLabel.messageLabel.text = date.formatStringDate(withFormat: "dd/MM/yyyy")
        
        fromLabel.messageLabel.text = sender.name
        fromLabel.documentLabel.text = sender.documentNumber
        fromLabel.bankNameLabel.text = sender.institutionName
        fromLabel.agencyAccountLabel.text = "Agência \(sender.agencyNumber ?? String()) - Conta \(sender.accountNumber ?? String())"
        
        toLabel.messageLabel.text = receiver.name
        toLabel.documentLabel.text = receiver.documentNumber
        toLabel.bankNameLabel.text = receiver.institutionName
        toLabel.agencyAccountLabel.text = "Agência \(receiver.agencyNumber ?? String()) - Conta \(receiver.accountNumber ?? String())"
    }
}
