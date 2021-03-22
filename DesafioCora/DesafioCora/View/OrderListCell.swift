//
//  OrderListCell.swift
//  DesafioCora
//
//  Created by Euclides Medeiros on 15/03/21.
//

import UIKit

class OrderListCell: UITableViewCell {
    
    // MARK: - Constants
    
    private let kPaidOut = "pago"
    private let kIdoNotPay = "não pago"
    
    // MARK: - Properties
    
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
        label.font = UIFont.systemFont(ofSize: 14)
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
    
    
    /// initializing views
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureViews()
        setupViewHierarchy()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    /// setting background color of the view
    func configureViews() {
        self.backgroundColor = .clear
        self.layer.borderColor = UIColor.white.cgColor
    }
    
    /// setting hierarchy of the view
    func setupViewHierarchy() {
        self.contentView.addSubview(logoWallet)
        self.contentView.addSubview(valueText)
        self.contentView.addSubview(emailText)
        self.contentView.addSubview(situationText )
        self.contentView.addSubview(payDayText)
        
    }
    
    /// setting constrains of the view
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
    
    
    /// function responsible for popular a cell
    /// - Parameters:
    ///   - purchaseValue: value in reais
    ///   - currentEmail: buyer email
    ///   - statusPayment: payment status
    ///   - payDay: pay day
    func setup(purchaseValue: Double, currentEmail: String, statusPayment: Bool, payDay: String ) {
        let formaterValue = String(format: "%.2f", purchaseValue)
        self.valueText.text = "R$ \(formaterValue)"
        self.emailText.text = currentEmail
        self.payDayText.text = payDay
        
        switch statusPayment {
        case true:
            self.situationText.text = kPaidOut
            self.situationText.textColor = .green
        default:
            self.situationText.text = kIdoNotPay
            self.situationText.textColor = .red
        }
    }
}
