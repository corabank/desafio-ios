//
//  OrderDetailView.swift
//  cora
//
//  Created by Lucas Silveira on 26/04/21.
//

import UIKit

class OrderDetailview: UIView {
    var viewModel: OrderDetailViewModel?
    
    // top
    private var title: UILabel!
    private var paymentView: UIView!
    private var paymentImageView: UIImageView!
    private var paymentValueLabel: UILabel!
    private var paymentTypeLabel: UILabel!
    
    private var buyerView: UIView!
    private var buyerImageView: UIImageView!
    private var buyerLabel: UILabel!
    private var buyerNameLabel: UILabel!
    
    private var emailView: UIView!
    private var emailImageView: UIImageView!
    private var emailLabel: UILabel!
    private var emailValueLabel: UILabel!
    
    private var createdView: UIView!
    private var createdImageView: UIImageView!
    private var createdAtLabel: UILabel!
    private var createdAtValueLabel: UILabel!
    
    private var statusView: UIView!
    private var statusImageView: UIImageView!
    private var statusLabel: UILabel!
    private var statusLabelValue: UILabel!
    
    // resume
    private var resumeView: UIView!
    private var resumeLabel: UILabel!
    
    private var totalAmountLabel: UILabel!
    private var totalAmountValueLabel: UILabel!
    
    private var taxesLabel: UILabel!
    private var taxesValueLabel: UILabel!
    
    private var myReceiveLabel: UILabel!
    private var myReceiveValueLabel: UILabel!
    
    func makeTopView() {
        title = .customLabel(textColor: .black, text: "Detail".localized, fontSize: 22, isBold: true)
        self.addSubview(title)

        // paymentView
        paymentView = UIView()
        paymentView.translatesAutoresizingMaskIntoConstraints = false
        
        // paymentImageView
        paymentImageView = .customImageView(named: "creditcard.circle.fill")
        paymentView.addSubview(paymentImageView)
        
        // paymentValueLabel
        paymentValueLabel = .customLabel(
            textColor: #colorLiteral(red: 0.1580600441, green: 0.1580889821, blue: 0.1580537558, alpha: 1),
            text: viewModel?.order.value.toCurrency ?? "",
            fontSize: 12.dp,
            isBold: true)
        paymentValueLabel.accessibilityIdentifier = "paymentValueLabel"
        paymentView.addSubview(paymentValueLabel)
        
        // paymentTypeLabel
        paymentTypeLabel = .customLabel(text: "Cartão de Crédito", fontSize: 9.dp)
        paymentView.addSubview(paymentTypeLabel)
        self.addSubview(paymentView)
        
        // buyerView
        buyerView = UIView()
        buyerView.translatesAutoresizingMaskIntoConstraints = false
        
        // buyerImageView
        buyerImageView = .customImageView(named: "person.circle.fill")
        buyerView.addSubview(buyerImageView)
        
        // buyerLabel
        buyerLabel = .customLabel(textColor: #colorLiteral(red: 0.5879337788, green: 0.5960012078, blue: 0.604257524, alpha: 1), text: "Buyer".localized, fontSize: 8.dp)
        buyerView.addSubview(buyerLabel)
        
        // buyerNameLabel
        buyerNameLabel = .customLabel(text: viewModel?.order.buyerName ?? "", fontSize: 10.dp)
        buyerView.addSubview(buyerNameLabel)
        self.addSubview(buyerView)
        
        // emailView
        emailView = UIView()
        emailView.translatesAutoresizingMaskIntoConstraints = false
        
        // emailImageView
        emailImageView = .customImageView(named: "envelope.circle.fill")
        emailView.addSubview(emailImageView)
        
        // emailLabel
        emailLabel = .customLabel(textColor: #colorLiteral(red: 0.5879337788, green: 0.5960012078, blue: 0.604257524, alpha: 1), text: "Email", fontSize: 8.dp)
        emailView.addSubview(emailLabel)
        
        // emailValueLabel
        emailValueLabel = .customLabel(text: viewModel?.order.buyerEmail ?? "", fontSize: 10.dp)
        emailView.addSubview(emailValueLabel)
        self.addSubview(emailView)
        
        // createdView
        createdView = UIView()
        createdView.translatesAutoresizingMaskIntoConstraints = false
        
        // createdImageView
        createdImageView = .customImageView(named: "calendar.circle.fill")
        createdView.addSubview(createdImageView)
        
        // createdAtLabel
        createdAtLabel = .customLabel(textColor: #colorLiteral(red: 0.5879337788, green: 0.5960012078, blue: 0.604257524, alpha: 1), text: "Created at".localized, fontSize: 8.dp)
        createdView.addSubview(createdAtLabel)
        
        // emailValueLabel
        let dateToStringFormatter = DateFormatter()
        dateToStringFormatter.dateFormat = "dd/MM/YYYY"
        createdAtValueLabel = .customLabel(
            text: dateToStringFormatter.string(from: viewModel?.order.createdAt ?? Date()),
            fontSize: 10.dp)
        createdView.addSubview(createdAtValueLabel)
        self.addSubview(createdView)
        
        // statusView
        statusView = UIView()
        statusView.translatesAutoresizingMaskIntoConstraints = false
        
        // statusImageView
        statusImageView = .customImageView(named: "circle.lefthalf.fill")
        statusView.addSubview(statusImageView)
        
        // statusLabel
        statusLabel = .customLabel(textColor: #colorLiteral(red: 0.5879337788, green: 0.5960012078, blue: 0.604257524, alpha: 1), text: "Status", fontSize: 8.dp)
        statusView.addSubview(statusLabel)
        
        // emailValueLabel
        var status = ""
        var color = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        switch viewModel?.order.status {
        case .late:
            status = "Not Paid".localized
            color = #colorLiteral(red: 1, green: 0.2321209311, blue: 0.4182785749, alpha: 1)
        case .paid:
            status = "Paid".localized
            color = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        case .pending:
            status = "Waiting".localized
            color = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        default: break
        }
        
        statusLabelValue = .customLabel(textColor: color, text: status, fontSize: 10.dp)
        statusView.addSubview(statusLabelValue)
        self.addSubview(statusView)
    }
    
    var receive: Double {
        let value = viewModel?.order.value ?? 0
        let taxes = viewModel?.order.taxes ?? 0
        
        return value - taxes
    }
    
    func makeResumeView() {
        resumeLabel = .customLabel(textColor: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), text: "Billing Resume".localized,
                                   fontSize: 13.dp, isBold: true)
        self.addSubview(resumeLabel)
        
        resumeView = UIView()
        resumeView.translatesAutoresizingMaskIntoConstraints = false
        resumeView.backgroundColor = #colorLiteral(red: 0.637691319, green: 0.6857426763, blue: 0.7274500728, alpha: 1)
        
        totalAmountLabel = .customLabel(textColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), text: "Total value".localized, fontSize: 12.dp)
        totalAmountValueLabel = .customLabel(textColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),
                                      text: viewModel?.order.value.toCurrency ?? "",
                                      fontSize: 12.dp)
        resumeView.addSubview(totalAmountLabel)
        resumeView.addSubview(totalAmountValueLabel)
        
        taxesLabel = .customLabel(textColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), text: "Taxes".localized, fontSize: 12.dp)
        taxesValueLabel = .customLabel(textColor: #colorLiteral(red: 1, green: 0.2321209311, blue: 0.4182785749, alpha: 1), text: viewModel?.order.taxes.toCurrency ?? "",
                                       fontSize: 12.dp)
        resumeView.addSubview(taxesLabel)
        resumeView.addSubview(taxesValueLabel)
        
        myReceiveLabel = .customLabel(textColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), text: "My receipt".localized, fontSize: 14.dp,
                                      isBold: true)
        myReceiveValueLabel = .customLabel(textColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), text: receive.toCurrency, fontSize: 14.dp,
                                           isBold: true)
        myReceiveValueLabel.accessibilityIdentifier = "myReceiveValueLabel"
        resumeView.addSubview(myReceiveLabel)
        resumeView.addSubview(myReceiveValueLabel)
        
        self.addSubview(resumeView)
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20.dp),
            title.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 12.dp),
            
            // payment
            paymentView.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 30.dp),
            paymentView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            paymentView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),

            paymentImageView.topAnchor.constraint(equalTo: paymentView.topAnchor, constant: 2.dp),
            paymentImageView.leadingAnchor.constraint(equalTo: paymentView.leadingAnchor, constant: 10.dp),
            paymentImageView.widthAnchor.constraint(equalToConstant: 36.dp),
            paymentImageView.heightAnchor.constraint(equalToConstant: 36.dp),

            paymentValueLabel.topAnchor.constraint(equalTo: paymentView.topAnchor, constant: 6.dp),
            paymentValueLabel.leadingAnchor.constraint(equalTo: paymentImageView.trailingAnchor,
                                                       constant: 17.dp),

            paymentTypeLabel.topAnchor.constraint(equalTo: paymentValueLabel.bottomAnchor, constant: 4.dp),
            paymentTypeLabel.leadingAnchor.constraint(equalTo: paymentImageView.trailingAnchor,
                                                      constant: 17.dp),

            // buyer
            buyerView.topAnchor.constraint(equalTo: paymentView.bottomAnchor, constant: 26.dp),
            buyerView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            buyerView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),

            buyerImageView.topAnchor.constraint(equalTo: buyerView.topAnchor, constant: 30.5.dp),
            buyerImageView.centerXAnchor.constraint(equalTo: paymentImageView.centerXAnchor),
            buyerImageView.widthAnchor.constraint(equalToConstant: 36.dp),
            buyerImageView.heightAnchor.constraint(equalToConstant: 36.dp),

            buyerLabel.topAnchor.constraint(equalTo: buyerView.topAnchor, constant: 36.dp),
            buyerLabel.leadingAnchor.constraint(equalTo: buyerImageView.trailingAnchor, constant: 17.dp),

            buyerNameLabel.topAnchor.constraint(equalTo: buyerLabel.bottomAnchor, constant: 4.dp),
            buyerNameLabel.leadingAnchor.constraint(equalTo: buyerImageView.trailingAnchor, constant: 17.dp),

            // email
            emailView.topAnchor.constraint(equalTo: buyerView.bottomAnchor, constant: 42.dp),
            emailView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            emailView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),

            emailImageView.topAnchor.constraint(equalTo: emailView.topAnchor, constant: 41.dp),
            emailImageView.centerXAnchor.constraint(equalTo: paymentImageView.centerXAnchor),
            emailImageView.widthAnchor.constraint(equalToConstant: 36.dp),
            emailImageView.heightAnchor.constraint(equalToConstant: 36.dp),

            emailLabel.topAnchor.constraint(equalTo: emailView.topAnchor, constant: 46.dp),
            emailLabel.leadingAnchor.constraint(equalTo: emailImageView.trailingAnchor, constant: 17.dp),

            emailValueLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 4.dp),
            emailValueLabel.leadingAnchor.constraint(equalTo: emailImageView.trailingAnchor,
                                                     constant: 17.dp),

            // createdAt
            createdView.topAnchor.constraint(equalTo: emailView.bottomAnchor, constant: 42.dp),
            createdView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            createdView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),

            createdImageView.topAnchor.constraint(equalTo: createdView.topAnchor, constant: 51.dp),
            createdImageView.centerXAnchor.constraint(equalTo: paymentImageView.centerXAnchor),
            createdImageView.widthAnchor.constraint(equalToConstant: 36.dp),
            createdImageView.heightAnchor.constraint(equalToConstant: 36.dp),

            createdAtLabel.topAnchor.constraint(equalTo: createdView.topAnchor, constant: 56.dp),
            createdAtLabel.leadingAnchor.constraint(equalTo: createdImageView.trailingAnchor,
                                                    constant: 17.dp),

            createdAtValueLabel.topAnchor.constraint(equalTo: createdAtLabel.bottomAnchor, constant: 4.dp),
            createdAtValueLabel.leadingAnchor.constraint(equalTo: createdImageView.trailingAnchor,
                                                         constant: 17.dp),

            // status
            statusView.topAnchor.constraint(equalTo: createdView.bottomAnchor, constant: 42.dp),
            statusView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            statusView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),

            statusImageView.topAnchor.constraint(equalTo: statusView.topAnchor, constant: 61.dp),
            statusImageView.centerXAnchor.constraint(equalTo: paymentImageView.centerXAnchor),
            statusImageView.widthAnchor.constraint(equalToConstant: 36.dp),
            statusImageView.heightAnchor.constraint(equalToConstant: 36.dp),

            statusLabel.topAnchor.constraint(equalTo: statusView.topAnchor, constant: 67.dp),
            statusLabel.leadingAnchor.constraint(equalTo: statusImageView.trailingAnchor, constant: 17.dp),

            statusLabelValue.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 4.dp),
            statusLabelValue.leadingAnchor.constraint(equalTo: statusImageView.trailingAnchor,
                                                      constant: 17.dp),
            
            // resume
            resumeLabel.topAnchor.constraint(equalTo: statusLabelValue.bottomAnchor, constant: 40.dp),
            resumeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12.dp),
            
            resumeView.topAnchor.constraint(equalTo: resumeLabel.bottomAnchor, constant: 15.dp),
            resumeView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            resumeView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            resumeView.heightAnchor.constraint(equalToConstant: 120.dp),

            // Left
            totalAmountLabel.topAnchor.constraint(equalTo: resumeView.topAnchor, constant: 25.dp),
            totalAmountLabel.leadingAnchor.constraint(equalTo: resumeView.leadingAnchor, constant: 20.dp),
            // Right
            totalAmountValueLabel.topAnchor.constraint(equalTo: resumeView.topAnchor, constant: 25.dp),
            totalAmountValueLabel.trailingAnchor.constraint(equalTo: resumeView.trailingAnchor,
                                                            constant: -20.dp),

            // Left
            taxesLabel.topAnchor.constraint(equalTo: totalAmountLabel.bottomAnchor, constant: 10.dp),
            taxesLabel.leadingAnchor.constraint(equalTo: resumeView.leadingAnchor, constant: 20.dp),
            // Right
            taxesValueLabel.topAnchor.constraint(equalTo: totalAmountLabel.bottomAnchor, constant: 10.dp),
            taxesValueLabel.trailingAnchor.constraint(equalTo: resumeView.trailingAnchor, constant: -20.dp),

            // Left
            myReceiveLabel.topAnchor.constraint(equalTo: taxesLabel.bottomAnchor, constant: 10.dp),
            myReceiveLabel.leadingAnchor.constraint(equalTo: resumeView.leadingAnchor, constant: 20.dp),
            // Right
            myReceiveValueLabel.topAnchor.constraint(equalTo: taxesLabel.bottomAnchor, constant: 10.dp),
            myReceiveValueLabel.trailingAnchor.constraint(equalTo: resumeView.trailingAnchor,
                                                          constant: -20.dp)
        ])
    }
    
    override func willMove(toWindow newWindow: UIWindow?) {
        super.willMove(toWindow: newWindow)
        makeTopView()
        makeResumeView()
        setConstraints()
    }

    override func didMoveToWindow() {
        super.didMoveToWindow()
    }
}
