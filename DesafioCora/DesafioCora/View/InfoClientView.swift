//
//  InfoClientView.swift
//  DesafioCora
//
//  Created by Euclides Medeiros on 16/03/21.
//

import UIKit

class InfoClientView: UIView {
    
    // MARK: - Properties
    
    var data: OrderListElement?
    
    // MARK: - Constants
    
    private let kCreditCard = "Cartão de crédito"
    private let kWallet = "Wallet"
    private let kBuyer = "Comprador"
    private let kPerson = "person"
    private let kMail = "Email"
    private let kletter = "letter"
    private let kDateCreation = "Criado em"
    private let kCalendar = "calendar"
    private let kStatus = "Status"
    private let kPaidOut = "Pago"
    private let kClock = "clock"
    private let kResume = "Resumo finaceiro"
    private let kTotValue = "Valor Total"
    private let kTaxes = "Taxas"
    private let kReceive = "Meu recebimento"
    private let kValue = "R$ 105.00"
    private let kSandbox = "sandbox: ERTYUITY-65432-765432-765433456-ERTYJMNBVCDFGHJK"
    
    
    let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = NSLayoutConstraint.Axis.vertical
        stack.distribution = UIStackView.Distribution.fill
        stack.spacing = 0.0
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    let stackViewBottom: UIStackView = {
        let stack = UIStackView()
        stack.axis = NSLayoutConstraint.Axis.vertical
        stack.distribution = UIStackView.Distribution.fill
        stack.spacing = 0.0
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    // MARK: - Initializers
    
    convenience init(_ data: OrderListElement?) {
        self.init()
        self.data = data
        setupStack()
        setupViewHierarchy()
        setupConstraints()
    }
    
    // MARK: - Public functions
    
    func setupViewHierarchy() {
        self.addSubview(stackView)
        
    }
    
    func setupConstraints() {
        stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true
        stackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 24).isActive = true
    }
    
    func setupStack() {
        
        
        guard let valueFormatted = data?.value,
              let type = data?.ownerPurchase,
              let mail = data?.mail,
              let dataPurchase = data?.date else { return }
        
        let formaterValue = String(format: "%.2f", valueFormatted)
        
        let purchaseModel: [PurchaseInfoDetails] = [
            PurchaseInfoDetails(valueAccount: String("R$ \(formaterValue)"), typeAccount: kCreditCard, imageName: kWallet),
            PurchaseInfoDetails(valueAccount: kBuyer, typeAccount: type, imageName: kPerson),
            PurchaseInfoDetails(valueAccount: kMail, typeAccount: mail, imageName: kletter),
            PurchaseInfoDetails(valueAccount: kDateCreation, typeAccount: dataPurchase, imageName: kCalendar),
            PurchaseInfoDetails(valueAccount: kStatus, typeAccount: kPaidOut, imageName: kClock)
        ]
        
        purchaseModel.forEach { (contents) in
            
            let logoScreen = UIImageView()
            logoScreen.contentMode = .scaleAspectFill
            logoScreen.image = UIImage(named: contents.imageName ?? "")
            logoScreen.translatesAutoresizingMaskIntoConstraints = false
            
            let nameText = UILabel()
            nameText.text = contents.valueAccount
            nameText.font = UIFont.boldSystemFont(ofSize: 16)
            nameText.textColor = .black
            nameText.translatesAutoresizingMaskIntoConstraints = false
            
            let descriptionText = UILabel()
            descriptionText.text = contents.typeAccount
            descriptionText.font = UIFont.boldSystemFont(ofSize: 16)
            descriptionText.translatesAutoresizingMaskIntoConstraints = false
            descriptionText.textColor = .gray
            
            
            let detailsView = UIView()
            let baseView = UIView()
            
            baseView.heightAnchor.constraint(equalToConstant: 55).isActive = true
            baseView.translatesAutoresizingMaskIntoConstraints = false
            baseView.addSubview(logoScreen)
            baseView.addSubview(detailsView)
            
            detailsView.centerYAnchor.constraint(equalTo: logoScreen.centerYAnchor, constant: 0).isActive = true
            detailsView.leadingAnchor.constraint(equalTo: logoScreen.trailingAnchor, constant: 16).isActive = true
            
            logoScreen.topAnchor.constraint(equalTo: baseView.topAnchor, constant: 16).isActive = true
            logoScreen.leadingAnchor.constraint(equalTo: baseView.leadingAnchor, constant: 16).isActive = true
            logoScreen.heightAnchor.constraint(equalToConstant: 24).isActive = true
            logoScreen.widthAnchor.constraint(equalToConstant: 24).isActive = true
            
            detailsView.translatesAutoresizingMaskIntoConstraints = false
            detailsView.addSubview(nameText)
            detailsView.addSubview(descriptionText)
            
            nameText.topAnchor.constraint(equalTo: detailsView.topAnchor, constant: 0).isActive = true
            nameText.leadingAnchor.constraint(equalTo: detailsView.leadingAnchor, constant: 0).isActive = true
            nameText.trailingAnchor.constraint(equalTo: detailsView.trailingAnchor, constant: 0).isActive = true
            
            descriptionText.topAnchor.constraint(equalTo: nameText.bottomAnchor, constant: 0).isActive = true
            descriptionText.leadingAnchor.constraint(equalTo: detailsView.leadingAnchor, constant: 0).isActive = true
            descriptionText.trailingAnchor.constraint(equalTo: detailsView.trailingAnchor, constant: 0).isActive = true
            descriptionText.bottomAnchor.constraint(equalTo: detailsView.bottomAnchor, constant: -8).isActive = true
            
            
            stackView.addArrangedSubview(baseView)
            
        }
        
        let labelDescription = UILabel()
        labelDescription.font = UIFont.systemFont(ofSize: 16)
        labelDescription.numberOfLines = 0
        labelDescription.text = kResume
        labelDescription.textColor = .gray
        labelDescription.translatesAutoresizingMaskIntoConstraints = false
        
        let descriptionView = UIView()
        descriptionView.translatesAutoresizingMaskIntoConstraints = false
        descriptionView.heightAnchor.constraint(equalToConstant: 55).isActive = true
        descriptionView.backgroundColor = UIColor(displayP3Red: 240/255, green: 240/255, blue: 248/255, alpha: 1.0)
        
        descriptionView.addSubview(labelDescription)
        
        labelDescription.topAnchor.constraint(equalTo: descriptionView.topAnchor, constant: 16).isActive = true
        labelDescription.leadingAnchor.constraint(equalTo: descriptionView.leadingAnchor, constant: 16).isActive = true
        labelDescription.trailingAnchor.constraint(equalTo: descriptionView.trailingAnchor, constant: -16).isActive = true
        
        stackView.addArrangedSubview(descriptionView)
        
        let totValueText = UILabel()
        totValueText.font = UIFont.boldSystemFont(ofSize: 16)
        totValueText.numberOfLines = 0
        totValueText.text = kTotValue
        totValueText.textColor = .gray
        totValueText.translatesAutoresizingMaskIntoConstraints = false
        
        
        let taxesText = UILabel()
        taxesText.font = UIFont.boldSystemFont(ofSize: 16)
        taxesText.numberOfLines = 0
        taxesText.text = kTaxes
        taxesText.textColor = .red
        taxesText.translatesAutoresizingMaskIntoConstraints = false
        
        
        let receiveText = UILabel()
        receiveText.font = UIFont.boldSystemFont(ofSize: 16)
        receiveText.numberOfLines = 0
        receiveText.text = kReceive
        receiveText.textColor = .blue
        receiveText.translatesAutoresizingMaskIntoConstraints = false
        
        
        let currentValue = UILabel()
        currentValue.font = UIFont.boldSystemFont(ofSize: 16)
        currentValue.numberOfLines = 0
        currentValue.text = formaterValue
        currentValue.textColor = .gray
        currentValue.translatesAutoresizingMaskIntoConstraints = false
        
        let currentTaxes = UILabel()
        currentTaxes.font = UIFont.boldSystemFont(ofSize: 16)
        currentTaxes.numberOfLines = 0
        currentTaxes.text = String(data?.taxes ?? 0.0)
        currentTaxes.textColor = .red
        currentTaxes.translatesAutoresizingMaskIntoConstraints = false
        
        
        let finalReceive = UILabel()
        finalReceive.font = UIFont.boldSystemFont(ofSize: 16)
        finalReceive.numberOfLines = 0
        finalReceive.text = kValue
        finalReceive.textColor = .blue
        finalReceive.translatesAutoresizingMaskIntoConstraints = false
        
        let viewTaxesAndTot = UIView()
        viewTaxesAndTot.translatesAutoresizingMaskIntoConstraints = false
        viewTaxesAndTot.backgroundColor = UIColor(displayP3Red: 240/255, green: 240/255, blue: 248/255, alpha: 1.0)
        
        viewTaxesAndTot.addSubview(totValueText)
        viewTaxesAndTot.addSubview(taxesText)
        viewTaxesAndTot.addSubview(receiveText)
        viewTaxesAndTot.addSubview(currentValue)
        viewTaxesAndTot.addSubview(currentTaxes)
        viewTaxesAndTot.addSubview(finalReceive)
        
        
        totValueText.topAnchor.constraint(equalTo: viewTaxesAndTot.topAnchor, constant: 16).isActive = true
        totValueText.leadingAnchor.constraint(equalTo: viewTaxesAndTot.leadingAnchor, constant: 16).isActive = true
        
        taxesText.topAnchor.constraint(equalTo: totValueText.bottomAnchor, constant: 8).isActive = true
        taxesText.leadingAnchor.constraint(equalTo: viewTaxesAndTot.leadingAnchor, constant: 16).isActive = true
        
        receiveText.topAnchor.constraint(equalTo: taxesText.bottomAnchor, constant: 24).isActive = true
        receiveText.leadingAnchor.constraint(equalTo: viewTaxesAndTot.leadingAnchor, constant: 16).isActive = true
        
        currentValue.topAnchor.constraint(equalTo: viewTaxesAndTot.topAnchor, constant: 16).isActive = true
        currentValue.trailingAnchor.constraint(equalTo: viewTaxesAndTot.trailingAnchor, constant: -16).isActive = true
        
        currentTaxes.topAnchor.constraint(equalTo: currentValue.bottomAnchor, constant: 8).isActive = true
        currentTaxes.trailingAnchor.constraint(equalTo: viewTaxesAndTot.trailingAnchor, constant: -16).isActive = true
        
        finalReceive.topAnchor.constraint(equalTo: currentTaxes.bottomAnchor, constant: 24).isActive = true
        finalReceive.trailingAnchor.constraint(equalTo: viewTaxesAndTot.trailingAnchor, constant: -16).isActive = true
        
        stackView.addArrangedSubview(viewTaxesAndTot)
        
        let labelBottom = UILabel()
        labelBottom.font = UIFont.boldSystemFont(ofSize: 16)
        labelBottom.numberOfLines = 0
        labelBottom.text = kSandbox
        labelBottom.textColor = .gray
        labelBottom.translatesAutoresizingMaskIntoConstraints = false
        
        let viewBottom = UIView()
        viewBottom.translatesAutoresizingMaskIntoConstraints = false
        viewBottom.heightAnchor.constraint(equalToConstant: 100).isActive = true
        viewBottom.addSubview(labelBottom)
        
        labelBottom.topAnchor.constraint(equalTo: viewBottom.topAnchor, constant: 8).isActive = true
        labelBottom.leadingAnchor.constraint(equalTo: viewBottom.leadingAnchor, constant: 16).isActive = true
        labelBottom.trailingAnchor.constraint(equalTo: viewBottom.trailingAnchor, constant: -16).isActive = true
        labelBottom.bottomAnchor.constraint(equalTo: viewBottom.bottomAnchor, constant: 0).isActive = true
        
        
        stackView.addArrangedSubview(viewBottom)
    }
}

