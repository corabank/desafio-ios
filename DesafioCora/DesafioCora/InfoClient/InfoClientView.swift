//
//  InfoClientView.swift
//  DesafioCora
//
//  Created by Euclides Medeiros on 16/03/21.
//

import UIKit

class InfoClientView: UIView {
    
    var purchaseModel: [PurchaseInfoDetails] = [
        PurchaseInfoDetails(valueAccount: "R$110,00", typeAccount: "Cartão de crédito", imageName: "Wallet"),
        PurchaseInfoDetails(valueAccount: "Comprador", typeAccount: "Caju Cacau", imageName: "person"),
        PurchaseInfoDetails(valueAccount: "Email", typeAccount: "euclides.sena@hotmail.com", imageName: "letter"),
        PurchaseInfoDetails(valueAccount: "Criado em", typeAccount: "03/03/2020", imageName: "calendar"),
        PurchaseInfoDetails(valueAccount: "Status", typeAccount: "Pago", imageName: "clock")
    ]
    
    let stackViewBase: UIStackView = {
        let stack = UIStackView()
        stack.axis = NSLayoutConstraint.Axis.vertical
        stack.distribution = UIStackView.Distribution.fill
        stack.spacing = 8.0
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
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
        stack.spacing = 28.0
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStack()
        setupViewHierarchy()
        setupConstraints()
        
        //nova
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViewHierarchy() {
        self.addSubview(stackView)
        
    }
    
    func setupConstraints() {
        stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true
        stackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
    }
    
    func setupStack() {
        
        purchaseModel.forEach { (contents) in
            
            let logoScreen = UIImageView()
            logoScreen.contentMode = .scaleAspectFill
            logoScreen.image = UIImage(named: contents.imageName ?? "")
            logoScreen.translatesAutoresizingMaskIntoConstraints = false
            
            let nameText = UILabel()
            nameText.text = contents.valueAccount
            nameText.font = UIFont.boldSystemFont(ofSize: 16)
            nameText.translatesAutoresizingMaskIntoConstraints = false
            
            let descriptionText = UILabel()
            descriptionText.text = contents.typeAccount
            descriptionText.font = UIFont.boldSystemFont(ofSize: 16)
            descriptionText.translatesAutoresizingMaskIntoConstraints = false
            
            
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
        
        //continua
        
        
        let labelBottom = UILabel()
        labelBottom.numberOfLines = 0
        labelBottom.text = "sandbox: SDFGHRDCVBHGF-2345676543-345676543-987654543-SDFGHNBVRTYU"
        stackView.addArrangedSubview(labelBottom)
        
    }
}

