//
//  ScheduleView.swift
//  desafio-ios
//
//  Created by Amaryllis Baldrez on 21/03/22.
//

import Foundation
import UIKit

class ScheduleView: UIView {
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .white
        self.setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "Transferência agendada"
        titleLabel.font = .boldSystemFont(ofSize: 18)
        return titleLabel
    }()
    
    lazy var iconClock: UIImageView = {
        let iconClock = UIImageView()
        iconClock.image = UIImage(named: "ic_time-clock")
        iconClock.sizeToFit()
        return iconClock
    }()
    
    lazy var titleValueLabel: UILabel = {
        let titleValueLabel = UILabel()
        titleValueLabel.text = "Valor"
        return titleValueLabel
    }()
    
    lazy var valueLabel: UILabel = {
        let valueLabel = UILabel()
        valueLabel.text = "R$30,00"
        valueLabel.numberOfLines = 2
        return valueLabel
    }()
    
    lazy var titleDateLabeL: UILabel = {
        let titleDateLabeL = UILabel()
        titleDateLabeL.text = "Data de transferencia"
        return titleDateLabeL
    }()
    
    lazy var dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.text = "Segunda Feira - 13/01/2020"
        return dateLabel
    }()
    
    lazy var senderLabel: UILabel = {
        let senderLabel = UILabel()
        senderLabel.text = "De"
        return senderLabel
    }()
    
    lazy var nameSender: UILabel = {
        let nameSender = UILabel()
        nameSender.text = "Leonardo Mendes"
        nameSender.font = .boldSystemFont(ofSize: 19)
        return nameSender
    }()
    
    lazy var cpfSender: UILabel = {
        let cpfSender = UILabel()
        cpfSender.text = "CPF 407.130.563-56"
        return cpfSender
    }()
    
    lazy var bankSender: UILabel = {
        let bankSender = UILabel()
        bankSender.text = "Banco Cora"
        return bankSender
    }()
    
    lazy var agencySender: UILabel = {
        let agencySender = UILabel()
        agencySender.text = "Agencia 6193"
        return agencySender
    }()
    
    lazy var accountSender: UILabel = {
        let accountSender = UILabel()
        accountSender.text = "Counta 43556-3"
        return accountSender
    }()
    
    lazy var recipientLabel: UILabel = {
        let recipientLabel = UILabel()
        recipientLabel.text = "Para"
        return recipientLabel
    }()
    
    lazy var nameRecipient: UILabel = {
        let nameRecipient = UILabel()
        nameRecipient.text = "Lucas Vallim"
        nameRecipient.font = .boldSystemFont(ofSize: 19)
        return nameRecipient
    }()
    
    lazy var cpfRecipient: UILabel = {
        let cpfRecipient = UILabel()
        cpfRecipient.text = "CPF 407.130.563-56"
        return cpfRecipient
    }()
    
    lazy var bankRecipient: UILabel = {
        let bankRecipient = UILabel()
        bankRecipient.text = "Banco Cora"
        return bankRecipient
    }()
    
    lazy var agencyRecipient: UILabel = {
        let agencyRecipient = UILabel()
        agencyRecipient.text = "Agencia 6193"
        return agencyRecipient
    }()
    
    lazy var accountRecipient: UILabel = {
        let accountRecipient = UILabel()
        accountRecipient.text = "Counta 43556-3"
        return accountRecipient
    }()
    
    func setupViews() {
        iconClock.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        senderLabel.translatesAutoresizingMaskIntoConstraints = false
        nameSender.translatesAutoresizingMaskIntoConstraints = false
        cpfSender.translatesAutoresizingMaskIntoConstraints = false
        bankSender.translatesAutoresizingMaskIntoConstraints = false
        agencySender.translatesAutoresizingMaskIntoConstraints = false
        accountSender.translatesAutoresizingMaskIntoConstraints = false
        recipientLabel.translatesAutoresizingMaskIntoConstraints = false
        nameRecipient.translatesAutoresizingMaskIntoConstraints = false
        cpfRecipient.translatesAutoresizingMaskIntoConstraints = false
        bankRecipient.translatesAutoresizingMaskIntoConstraints = false
        agencyRecipient.translatesAutoresizingMaskIntoConstraints = false
        accountRecipient.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(iconClock)
        addSubview(titleLabel)
        addSubview(valueLabel)
        addSubview(dateLabel)
        addSubview(senderLabel)
        addSubview(nameSender)
        addSubview(cpfSender)
        addSubview(bankSender)
        addSubview(agencySender)
        addSubview(accountSender)
        addSubview(recipientLabel)
        addSubview(nameRecipient)
        addSubview(cpfRecipient)
        addSubview(bankRecipient)
        addSubview(agencyRecipient)
        addSubview(accountRecipient)

        NSLayoutConstraint.activate([
            iconClock.topAnchor.constraint(equalToSystemSpacingBelow: self.topAnchor, multiplier: 15.0),
            iconClock.leftAnchor.constraint(equalToSystemSpacingAfter: self.leftAnchor, multiplier: 1.00),
            iconClock.heightAnchor.constraint(lessThanOrEqualTo: self.heightAnchor, multiplier: 1.00),
            iconClock.widthAnchor.constraint(lessThanOrEqualTo: self.widthAnchor, multiplier: 1.00)
            
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: iconClock.topAnchor),
            titleLabel.leftAnchor.constraint(equalToSystemSpacingAfter: iconClock.rightAnchor, multiplier: 0.40)
        ])
        
        NSLayoutConstraint.activate([
            valueLabel.topAnchor.constraint(equalToSystemSpacingBelow: iconClock.bottomAnchor, multiplier: 2.0),
            valueLabel.leftAnchor.constraint(equalTo: iconClock.rightAnchor)
        ])
       
        
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalToSystemSpacingBelow: valueLabel.bottomAnchor, multiplier: 0.50),
            dateLabel.leftAnchor.constraint(equalTo: valueLabel.leftAnchor)
        ])
        
        NSLayoutConstraint.activate([
            senderLabel.topAnchor.constraint(equalToSystemSpacingBelow: dateLabel.bottomAnchor, multiplier: 3.50),
            senderLabel.leftAnchor.constraint(equalTo: dateLabel.leftAnchor),
            senderLabel.heightAnchor.constraint(equalTo: dateLabel.heightAnchor)
        ])

        
        NSLayoutConstraint.activate([
            nameSender.topAnchor.constraint(equalToSystemSpacingBelow: senderLabel.bottomAnchor, multiplier: 1.30),
            nameSender.leftAnchor.constraint(equalTo: dateLabel.leftAnchor),
            nameSender.heightAnchor.constraint(equalTo: dateLabel.heightAnchor)
        ])

        NSLayoutConstraint.activate([
            cpfSender.topAnchor.constraint(equalTo: nameSender.bottomAnchor),
            cpfSender.leftAnchor.constraint(equalTo: nameSender.leftAnchor),
            cpfSender.heightAnchor.constraint(equalTo: nameSender.heightAnchor)
        ])

        NSLayoutConstraint.activate([
            bankSender.topAnchor.constraint(equalToSystemSpacingBelow: cpfSender.bottomAnchor, multiplier: 0.50),
            bankSender.leftAnchor.constraint(equalTo: cpfSender.leftAnchor),
            bankSender.heightAnchor.constraint(equalTo: cpfSender.heightAnchor)
        ])

        NSLayoutConstraint.activate([
            agencySender.topAnchor.constraint(equalToSystemSpacingBelow: bankSender.bottomAnchor, multiplier: 0.50),
            agencySender.leftAnchor.constraint(equalTo: bankSender.leftAnchor),
            agencySender.heightAnchor.constraint(equalTo: bankSender.heightAnchor)
        ])

        NSLayoutConstraint.activate([
            accountSender.topAnchor.constraint(equalToSystemSpacingBelow: bankSender.bottomAnchor, multiplier: 0.50),
            accountSender.leftAnchor.constraint(equalToSystemSpacingAfter: agencySender.rightAnchor, multiplier: 0.50),
            accountSender.heightAnchor.constraint(equalTo: agencySender.heightAnchor)
        ])
        
        NSLayoutConstraint.activate([
            recipientLabel.topAnchor.constraint(equalToSystemSpacingBelow: agencySender.bottomAnchor, multiplier: 2.50),
            recipientLabel.leftAnchor.constraint(equalTo: agencySender.leftAnchor)
        ])

        NSLayoutConstraint.activate([
            nameRecipient.topAnchor.constraint(equalToSystemSpacingBelow: recipientLabel.bottomAnchor, multiplier: 1.30),
            nameRecipient.leftAnchor.constraint(equalTo: recipientLabel.leftAnchor)
        ])

        NSLayoutConstraint.activate([
            cpfRecipient.topAnchor.constraint(equalToSystemSpacingBelow: nameRecipient.bottomAnchor, multiplier: 1.00),
            cpfRecipient.leftAnchor.constraint(equalTo: nameRecipient.leftAnchor)
        ])

        NSLayoutConstraint.activate([
            bankRecipient.topAnchor.constraint(equalToSystemSpacingBelow: cpfRecipient.bottomAnchor, multiplier: 1.00),
            bankRecipient.leftAnchor.constraint(equalTo: cpfRecipient.leftAnchor)
        ])

        NSLayoutConstraint.activate([
            agencyRecipient.topAnchor.constraint(equalToSystemSpacingBelow: bankRecipient.bottomAnchor, multiplier: 1.00),
            agencyRecipient.leftAnchor.constraint(equalTo: bankSender.leftAnchor)
        ])

        NSLayoutConstraint.activate([
            accountRecipient.topAnchor.constraint(equalToSystemSpacingBelow: bankRecipient.bottomAnchor, multiplier: 1.00),
            accountRecipient.leftAnchor.constraint(equalToSystemSpacingAfter: agencyRecipient.rightAnchor, multiplier: 0.50)
        ])
        
    }
    
}
