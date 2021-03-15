//
//  OrderListCell.swift
//  DesafioCora
//
//  Created by Euclides Medeiros on 15/03/21.
//

import UIKit

class OrderListCell: UITableViewCell {
    
    var logoWallet: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "Wallet")
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    let valueText: UILabel  = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    let emailText: UILabel  = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    let situationText: UILabel  = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    let payDayText: UILabel  = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureViews()
        setupViewHierarchy()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureViews() {
        self.backgroundColor = .clear
        self.layer.borderColor = UIColor.white.cgColor
    }
    
    func setupViewHierarchy() {
        self.contentView.addSubview(logoWallet)
        self.contentView.addSubview(valueText)
        self.contentView.addSubview(emailText)
        self.contentView.addSubview(situationText )
        self.contentView.addSubview(payDayText)
        
    }
    
    func setupConstraints() {
        
        self.logoWallet.snp.makeConstraints { make in
            make.centerY.equalTo(contentView.snp.centerY)
            make.leading.equalTo(snp.leading).offset(12)
            make.height.equalTo(24)
            make.width.equalTo(24)
        }
        
        self.valueText.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(24)
            make.leading.equalTo(logoWallet.snp.trailing).offset(16)
            
        }
        
        self.emailText.snp.makeConstraints { make in
            make.top.equalTo(valueText.snp.bottom).offset(8)
            make.leading.equalTo(logoWallet.snp.trailing).offset(16)
        }
        
        self.situationText.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(24)
            make.trailing.equalTo(contentView.snp.trailing).offset(-16)
        }
        
        self.payDayText.snp.makeConstraints { make in
            make.top.equalTo(situationText.snp.bottom).offset(8)
            make.trailing.equalTo(contentView.snp.trailing).offset(-16)
        }
    }
    
    func setup(purchaseValue: String, currentEmail: String, statusPayment: String, payDay: String ) {
        self.valueText.text = purchaseValue
        self.emailText.text = currentEmail
        self.situationText.text = statusPayment
        self.payDayText.text = payDay
    }
}
